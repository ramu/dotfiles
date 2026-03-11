#!/bin/bash
# Claude Code statusline
input=$(cat)

# Extract all fields in a single jq call
eval "$(echo "$input" | jq -r '
  @sh "MODEL=\(.model.display_name // "---")",
  @sh "TOTAL_IN=\(.context_window.total_input_tokens // 0)",
  @sh "TOTAL_OUT=\(.context_window.total_output_tokens // 0)",
  @sh "PCT=\(.context_window.used_percentage // 0 | floor)",
  @sh "COST=\(.cost.total_cost_usd // 0)",
  @sh "API_MS=\(.cost.total_api_duration_ms // 0 | floor)",
  @sh "AGENT=\(.agent.name // "")",
  @sh "DIR=\(.workspace.current_dir // "")"
')"

# Sanitize PCT to ensure it's a valid integer
PCT=${PCT:-0}
[[ "$PCT" =~ ^[0-9]+$ ]] || PCT=0

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BLUE='\033[34m'
MAGENTA='\033[35m'
DIM='\033[2m'
RESET='\033[0m'

# Format tokens in pure bash (e.g. 15234 -> 15.2k)
fmt_tokens() {
  local t=$1
  if [ "$t" -ge 1000000 ]; then
    local whole=$((t / 1000000))
    local frac=$(( (t % 1000000) / 100000 ))
    printf '%d.%dM' "$whole" "$frac"
  elif [ "$t" -ge 1000 ]; then
    local whole=$((t / 1000))
    local frac=$(( (t % 1000) / 100 ))
    printf '%d.%dk' "$whole" "$frac"
  else
    printf '%d' "$t"
  fi
}

IN_FMT=$(fmt_tokens "$TOTAL_IN")
OUT_FMT=$(fmt_tokens "$TOTAL_OUT")

# Progress bar with color based on usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

BAR_WIDTH=20
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '█')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '░')"

# Format cost
COST_FMT=$(printf '$%.4f' "$COST")

# Format API duration
API_SEC=$((API_MS / 1000))
API_MINS=$((API_SEC / 60))
API_SECS=$((API_SEC % 60))
if [ "$API_MINS" -gt 0 ]; then
  DURATION_FMT="${API_MINS}m${API_SECS}s"
else
  DURATION_FMT="${API_SECS}s"
fi

# Agent name display
AGENT_FMT=""
[ -n "$AGENT" ] && AGENT_FMT=" ${MAGENTA}🤖 ${AGENT}${RESET}"

# Model + tokens + agent
printf '%b' "${CYAN}[${MODEL}${RESET}] | 📥 ${IN_FMT} 📤 ${OUT_FMT}${AGENT_FMT} | "
# Progress bar + cost + duration
printf '%b' "${BAR_COLOR}${BAR}${RESET} ${DIM}${PCT}%${RESET} | 💰 ${YELLOW}${COST_FMT}${RESET} | ⏱️  ${BLUE}${DURATION_FMT}${RESET}\n"

# Git status with colors
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    GIT_STATUS=""
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"

    printf '%b' "📁 ${DIR##*/} | 🌿 ${CYAN}${BRANCH}${RESET} ${GIT_STATUS}"
else
    printf '%b' "📁 ${DIR##*/}"
fi

# --- Rate limit usage (OAuth API with cache) ---
CACHE_FILE="/tmp/claude-usage-cache.json"
CACHE_TTL=360

usage_color() {
  local pct=$1
  if [ "$pct" -ge 90 ]; then printf '%s' "$RED"
  elif [ "$pct" -ge 70 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

fetch_usage() {
  local now
  now=$(date +%s)

  # Check cache
  if [ -f "$CACHE_FILE" ]; then
    local cached_at
    cached_at=$(jq -r '.cached_at // 0' "$CACHE_FILE" 2>/dev/null)
    if [ $(( now - cached_at )) -lt "$CACHE_TTL" ]; then
      cat "$CACHE_FILE"
      return
    fi
  fi

  # Get OAuth token from macOS keychain
  local token access_token
  token=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null || true)
  access_token=$(echo "$token" | jq -r '.claudeAiOauth.accessToken // .accessToken // .access_token // empty' 2>/dev/null || true)

  if [ -z "$access_token" ]; then
    return 1
  fi

  # Call usage API
  local response
  response=$(curl -sf --max-time 5 \
    -H "Authorization: Bearer ${access_token}" \
    -H "anthropic-beta: oauth-2025-04-20" \
    "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)

  if [ -z "$response" ]; then
    return 1
  fi

  # Save to cache with timestamp
  echo "$response" | jq --arg ts "$now" '. + {cached_at: ($ts | tonumber)}' > "$CACHE_FILE" 2>/dev/null
  echo "$response" | jq --arg ts "$now" '. + {cached_at: ($ts | tonumber)}'
}

format_reset_time() {
  local reset_at=$1
  if [ -z "$reset_at" ] || [ "$reset_at" = "null" ]; then
    return
  fi
  # Convert to local 12-hour format (e.g. "8pm", "7am")
  if command -v gdate &>/dev/null; then
    gdate -d "$reset_at" '+%-I%P' 2>/dev/null
  else
    local formatted
    formatted=$(LC_TIME=C date -jf '%Y-%m-%dT%H:%M:%S' "${reset_at%%.*}" '+%-I%p' 2>/dev/null || \
      LC_TIME=C date -jf '%Y-%m-%dT%H:%M:%SZ' "${reset_at%%.*}Z" '+%-I%p' 2>/dev/null) || true
    formatted=$(echo "$formatted" | tr '[:upper:]' '[:lower:]')
    if [ -n "$formatted" ]; then
      echo "$formatted"
    else
      echo "${reset_at:11:5}"
    fi
  fi
}

usage_json=$(fetch_usage 2>/dev/null)

if [ -n "$usage_json" ]; then
  five_util=$(echo "$usage_json" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
  five_reset=$(echo "$usage_json" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)
  seven_util=$(echo "$usage_json" | jq -r '.seven_day.utilization // empty' 2>/dev/null)
  seven_reset=$(echo "$usage_json" | jq -r '.seven_day.resets_at // empty' 2>/dev/null)

  five_pct=0
  seven_pct=0
  [ -n "$five_util" ] && five_pct=$(printf '%.0f' "$five_util")
  [ -n "$seven_util" ] && seven_pct=$(printf '%.0f' "$seven_util")

  five_reset_fmt=$(format_reset_time "$five_reset")
  seven_reset_fmt=$(format_reset_time "$seven_reset")

  five_color=$(usage_color "$five_pct")
  seven_color=$(usage_color "$seven_pct")

  printf '%b' " | Session: ${five_color}${five_pct}%${RESET}"
  [ -n "$five_reset_fmt" ] && printf '%b' " ${DIM}(reset ${five_reset_fmt})${RESET}"
  printf '%b' " | Week: ${seven_color}${seven_pct}%${RESET}"
  [ -n "$seven_reset_fmt" ] && printf '%b' " ${DIM}(reset ${seven_reset_fmt})${RESET}"
  printf '\n'
else
  printf '\n'
fi
