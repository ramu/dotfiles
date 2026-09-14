#!/bin/bash

# Claude Code PreToolUse hook: --dangerously-skip-permissions 使用時でも permissions.deny を強制適用するスクリプト
# settings.json の Bash 拒否パターンをチェックし、該当するコマンドの実行を阻止します
#
# 検査はコマンド文字列の静的な走査であり、以下は検出できない:
#   - bash -c "..." や eval のように、引数の中身が実行時に解釈されるもの
#   - $(...) や `...` によるコマンド置換
# 逆に、引数の中に区切り文字と拒否対象の語が並ぶと誤検知する
# (例: echo "a | sudo b" は sudo の実行として拒否される)。
# 取りこぼしよりは誤検知を許容する方針で、区切り文字での分割を優先している。
#
# 挙動は scripts/deny-check.test.sh で確認できる。

# Configuration
SETTINGS_FILE="${HOME}/.claude/settings.json"
LOG_FILE="${HOME}/tmp/deny-check.log"
DEBUG="${CLAUDE_DEBUG:-false}"
# 1 メッセージの上限文字数。超過分は切り詰める
LOG_MAX_MESSAGE_CHARS=500
# ログのサイズ上限。超えたら .1 へ退避して作り直す
LOG_MAX_BYTES=5242880

# サイズ上限を超えたログを 1 世代だけ退避する
rotate_log_if_needed() {
  [ -f "$LOG_FILE" ] || return 0

  local size
  size=$(wc -c < "$LOG_FILE" 2>/dev/null | tr -d ' ')
  [ -n "$size" ] && [ "$size" -gt "$LOG_MAX_BYTES" ] || return 0

  mv "$LOG_FILE" "${LOG_FILE}.1" 2>/dev/null
}

# Logging function
# DENY / ERROR のみ常時記録する。INFO / ALLOW は全 Bash コマンドの写しになり
# 資格情報まで平文で残るため、CLAUDE_DEBUG=true のときだけ出力する。
log_message() {
  local level="$1"
  shift
  local message="$*"

  # 改行・タブを空白へ畳み、1 イベント 1 行に収める
  message=$(printf '%s' "$message" | tr '\n\t' '  ')
  if [ "${#message}" -gt "$LOG_MAX_MESSAGE_CHARS" ]; then
    message="${message:0:$LOG_MAX_MESSAGE_CHARS}…(truncated)"
  fi

  if [ "$DEBUG" = "true" ]; then
    echo "DEBUG: $message" >&2
  fi

  case "$level" in
    DENY | ERROR) ;;
    *) [ "$DEBUG" = "true" ] || return 0 ;;
  esac

  mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null
  rotate_log_if_needed
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
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

# 複合コマンドを個別のコマンドへ分割する。
# && と || を先に潰してから & と | を扱わないと、区切りを二重に割ってしまう。
split_command() {
  local cmd="$1"

  cmd="${cmd//&&/$'\n'}"
  cmd="${cmd//||/$'\n'}"
  cmd="${cmd//;/$'\n'}"
  cmd="${cmd//|/$'\n'}"
  cmd="${cmd//&/$'\n'}"

  printf '%s\n' "$cmd"
}

# deny パターンと比較できる形へコマンドを整える。
# 空白の畳み込み、ラッパーの除去、パス指定の除去を行う。
normalize_command() {
  local cmd="$1"
  local first rest

  # 連続する空白を 1 個へ畳んでから前後をトリムする。
  # "chmod  777 x" のような表記揺れでプレフィックス比較が外れないようにするため。
  cmd=$(printf '%s' "$cmd" | tr -s '[:space:]' ' ')
  cmd="${cmd#"${cmd%%[![:space:]]*}"}"
  cmd="${cmd%"${cmd##*[![:space:]]}"}"

  # 実体のコマンドへ委譲するだけのラッパーと、一時的な環境変数指定を剥がす。
  # "command rm x" や "env FOO=bar rm x" を "rm x" として扱うため。
  while [ -n "$cmd" ]; do
    first="${cmd%% *}"
    rest="${cmd#* }"
    [ "$rest" = "$cmd" ] && rest=""

    case "$first" in
      [A-Za-z_]*=*) ;;
      command | builtin | exec | nohup | env | time) ;;
      *) break ;;
    esac

    cmd="$rest"
  done

  [ -n "$cmd" ] || return 0

  # "/bin/rm" のようなパス指定をコマンド名だけへ正規化する
  first="${cmd%% *}"
  rest="${cmd#* }"
  [ "$rest" = "$cmd" ] && rest=""
  case "$first" in
    */*) first="${first##*/}" ;;
  esac

  if [ -n "$rest" ]; then
    printf '%s %s' "$first" "$rest"
  else
    printf '%s' "$first"
  fi
}

# Pattern matching with improved logic
matches_deny_pattern() {
  local cmd="$1"
  local pattern="$2"

  # Extract the pattern prefix (before :)
  local pattern_prefix
  pattern_prefix="${pattern%%:*}"

  # プレフィックスは "chmod 777" のように複数語を含みうるため、先頭 1 語だけでは
  # 比較できない。語の区切りでの前方一致にして "chmod 7777" を巻き込まないようにする。
  if [[ "$pattern" == *":*" ]]; then
    [[ "$cmd" == "$pattern_prefix" || "$cmd" == "$pattern_prefix "* ]]
  else
    # Exact glob pattern matching
    [[ "$cmd" == $pattern ]]
  fi
}

# deny パターンは 1 回だけ読み込んで使い回す。
# 以前はキャッシュファイルを作っていたが、ファイル名に $$ を含むため
# プロセスをまたいで再利用されず、~/.claude に取り残しが溜まるだけだった。
DENY_PATTERNS=""
load_deny_patterns() {
  DENY_PATTERNS=$(jq -r '.permissions.deny[] | select(startswith("Bash(")) | gsub("^Bash\\("; "") | gsub("\\)$"; "")' "$SETTINGS_FILE" 2>/dev/null) ||
    error_exit "Failed to parse deny patterns from settings.json" 1
}

# Check command against deny patterns
check_command() {
  local command="$1"
  local normalized
  normalized=$(normalize_command "$command")
  [ -n "$normalized" ] || return 0

  while IFS= read -r pattern; do
    # skip blank lines
    [ -z "$pattern" ] && continue

    if matches_deny_pattern "$normalized" "$pattern"; then
      log_message "DENY" "Command blocked: '$command' (pattern: '$pattern')"
      error_exit "コマンドが拒否されました: '$command' (パターン: '$pattern')"
    fi
  done <<<"$DENY_PATTERNS"
}

# Main execution
main() {
  check_dependencies
  parse_input
  load_deny_patterns

  # Only check Bash commands
  if [ "$tool_name" != "Bash" ]; then
    log_message "INFO" "Skipping non-Bash tool: $tool_name"
    exit 0
  fi

  # Check full command
  check_command "$command"

  # Split and check compound commands
  local cmd_part
  while IFS= read -r cmd_part; do
    # skip blank lines
    [ -z "${cmd_part//[[:space:]]/}" ] && continue
    check_command "$cmd_part"
  done <<<"$(split_command "$command")"

  log_message "ALLOW" "Command allowed: $command"
  exit 0
}

# Run main function
main
