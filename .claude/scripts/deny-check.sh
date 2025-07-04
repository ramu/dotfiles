#!/bin/bash

# Claude Code PreToolUse hook: --dangerously-skip-permissions 使用時でも permissions.deny を強制適用するスクリプト
# settings.json の Bash 拒否パターンをチェックし、該当するコマンドの実行を阻止します

# Configuration
SETTINGS_FILE="${HOME}/.claude/settings.json"
LOG_FILE="${HOME}/tmp/deny-check.log"
DEBUG="${CLAUDE_DEBUG:-false}"

# Logging function
log_message() {
  local level="$1"
  shift
  local message="$*"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"

  if [ "$DEBUG" = "true" ]; then
    echo "DEBUG: $message" >&2
  fi
}

# Error handling
error_exit() {
  local message="$1"
  local exit_code="${2:-2}"
  log_message "ERROR" "$message"
  echo "Error: $message" >&2
  exit "$exit_code"
}

# Dependency check
check_dependencies() {
  if ! command -v jq >/dev/null 2>&1; then
    error_exit "jq is required but not installed" 1
  fi

  if [ ! -f "$SETTINGS_FILE" ]; then
    error_exit "Settings file not found: $SETTINGS_FILE" 1
  fi
}

# JSON input parsing with error handling
parse_input() {
  local input
  input=$(cat)

  if [ -z "$input" ]; then
    error_exit "No input provided" 1
  fi

  # Parse command and tool name
  command=$(echo "$input" | jq -r '.tool_input.command' 2>/dev/null)
  tool_name=$(echo "$input" | jq -r '.tool_name' 2>/dev/null)

  if [ "$command" = "null" ] || [ "$tool_name" = "null" ]; then
    error_exit "Invalid JSON input format" 1
  fi

  log_message "INFO" "Checking tool: $tool_name, command: $command"
}

# Pattern matching with improved logic
matches_deny_pattern() {
  local cmd="$1"
  local pattern="$2"

  # Trim whitespace
  cmd="${cmd#"${cmd%%[![:space:]]*}"}"
  cmd="${cmd%"${cmd##*[![:space:]]}"}"

  # Extract the base command from the input
  local base_cmd
  base_cmd=$(echo "$cmd" | awk '{print $1}')

  # Extract the pattern prefix (before :)
  local pattern_prefix
  pattern_prefix="${pattern%%:*}"

  # If pattern ends with :*, match the base command against the prefix
  if [[ "$pattern" == *":*" ]]; then
    [[ "$base_cmd" == "$pattern_prefix" ]]
  else
    # Exact glob pattern matching
    [[ "$cmd" == $pattern ]]
  fi
}

# Get deny patterns with caching
get_deny_patterns() {
  local cache_file="${HOME}/.claude/claude_deny_patterns_$$"

  if [ ! -f "$cache_file" ] || [ "$SETTINGS_FILE" -nt "$cache_file" ]; then
    jq -r '.permissions.deny[] | select(startswith("Bash(")) | gsub("^Bash\\("; "") | gsub("\\)$"; "")' "$SETTINGS_FILE" 2>/dev/null > "$cache_file"

    if [ $? -ne 0 ]; then
      error_exit "Failed to parse deny patterns from settings.json" 1
    fi
  fi

  cat "$cache_file"
}

# Check command against deny patterns
check_command() {
  local command="$1"
  local deny_patterns
  deny_patterns=$(get_deny_patterns)

  while IFS= read -r pattern; do
    # skip blank lines
    [ -z "$pattern" ] && continue

    if matches_deny_pattern "$command" "$pattern"; then
      log_message "DENY" "Command blocked: '$command' (pattern: '$pattern')"
      error_exit "コマンドが拒否されました: '$command' (パターン: '$pattern')"
    fi
  done <<<"$deny_patterns"
}

# Main execution
main() {
  check_dependencies
  parse_input

  # Only check Bash commands
  if [ "$tool_name" != "Bash" ]; then
    log_message "INFO" "Skipping non-Bash tool: $tool_name"
    exit 0
  fi

  # Check full command
  check_command "$command"

  # Split and check compound commands
  local temp_command="${command//;/$'\n'}"
  temp_command="${temp_command//&&/$'\n'}"
  temp_command="${temp_command//\|\|/$'\n'}"

  IFS=$'\n'
  for cmd_part in $temp_command; do
    # skip blank lines
    [ -z "$(echo "$cmd_part" | tr -d '[:space:]')" ] && continue
    check_command "$cmd_part"
  done

  log_message "ALLOW" "Command allowed: $command"
  exit 0
}

# Cleanup on exit
cleanup() {
  rm -f "${HOME}/.claude/claude_deny_patterns_$$" 2>/dev/null
}
trap cleanup EXIT

# Run main function
main
