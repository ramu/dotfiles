#!/bin/bash
# Claude Code statusline
input=$(cat)

# Extract all fields in a single jq call
eval "$(echo "$input" | jq -r '
  @sh "MODEL=\(.model.display_name // "---")",
  @sh "PCT=\(.context_window.used_percentage // 0 | floor)",
  @sh "AGENT=\(.agent.name // "")",
  @sh "DIR=\(.workspace.current_dir // "")",
  @sh "FIVE_PCT=\(.rate_limits.five_hour.used_percentage // -1 | floor)",
  @sh "FIVE_RESET=\(.rate_limits.five_hour.resets_at // "")",
  @sh "SEVEN_PCT=\(.rate_limits.seven_day.used_percentage // -1 | floor)",
  @sh "SEVEN_RESET=\(.rate_limits.seven_day.resets_at // "")"
')"

# Sanitize to ensure valid integers
PCT=${PCT:-0}; [[ "$PCT" =~ ^[0-9]+$ ]] || PCT=0
FIVE_PCT=${FIVE_PCT:--1}; [[ "$FIVE_PCT" =~ ^-?[0-9]+$ ]] || FIVE_PCT=-1
SEVEN_PCT=${SEVEN_PCT:--1}; [[ "$SEVEN_PCT" =~ ^-?[0-9]+$ ]] || SEVEN_PCT=-1

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
DIM='\033[2m'
RESET='\033[0m'

# Ring Meter: ○◔◑◕● (5 levels)
ring_meter() {
  local pct=$1
  if [ "$pct" -lt 20 ]; then   echo "○"
  elif [ "$pct" -lt 40 ]; then echo "◔"
  elif [ "$pct" -lt 60 ]; then echo "◑"
  elif [ "$pct" -lt 80 ]; then echo "◕"
  else                         echo "●"
  fi
}

# Color by percentage threshold
pct_color() {
  local pct=$1
  if [ "$pct" -ge 90 ]; then   printf '%s' "$RED"
  elif [ "$pct" -ge 70 ]; then printf '%s' "$YELLOW"
  else                         printf '%s' "$GREEN"
  fi
}

# Format reset timestamp to local time (e.g. "3pm")
format_reset_time() {
  local reset_at=$1
  [ -z "$reset_at" ] || [ "$reset_at" = "null" ] && return

  local ts formatted
  # Unix timestamp (seconds)
  if [[ "$reset_at" =~ ^[0-9]+$ ]]; then
    ts=$reset_at
  # Unix timestamp (milliseconds)
  elif [[ "$reset_at" =~ ^[0-9]{13}$ ]]; then
    ts=$(( reset_at / 1000 ))
  # ISO 8601 format
  else
    if command -v gdate &>/dev/null; then
      formatted=$(gdate -d "$reset_at" '+%-I%P' 2>/dev/null)
    else
      formatted=$(LC_TIME=C date -jf '%Y-%m-%dT%H:%M:%S' "${reset_at%%.*}" '+%-I%p' 2>/dev/null || \
        LC_TIME=C date -jf '%Y-%m-%dT%H:%M:%SZ' "${reset_at%%.*}Z" '+%-I%p' 2>/dev/null) || true
      formatted=$(echo "$formatted" | tr '[:upper:]' '[:lower:]')
    fi
    [ -n "$formatted" ] && echo "$formatted" || echo "${reset_at:11:5}"
    return
  fi

  # Format from unix timestamp
  formatted=$(LC_TIME=C date -r "$ts" '+%-I%p' 2>/dev/null) || true
  formatted=$(echo "$formatted" | tr '[:upper:]' '[:lower:]')
  [ -n "$formatted" ] && echo "$formatted"
}

# --- Line 1: Model + Agent + Dir + Git ---
AGENT_FMT=""
[ -n "$AGENT" ] && AGENT_FMT=" ${MAGENTA}🤖 ${AGENT}${RESET}"

CTX_COLOR=$(pct_color "$PCT")
printf '%b' "${CYAN}[${MODEL}]${RESET}${AGENT_FMT}"

if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    LINES_ADDED=$(git diff --numstat 2>/dev/null | awk '{s+=$1} END {print s+0}')
    LINES_REMOVED=$(git diff --numstat 2>/dev/null | awk '{s+=$2} END {print s+0}')

    GIT_STATUS=""
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS=" | ${YELLOW}M:${MODIFIED}${RESET} (${GREEN}+${LINES_ADDED}${RESET}/${RED}-${LINES_REMOVED}${RESET})"

    printf '%b' " | 📁 ${DIR##*/} | 🌿 ${CYAN}${BRANCH}${RESET}${GIT_STATUS}"
else
    printf '%b' " | 📁 ${DIR##*/}"
fi
printf '\n'

# --- Line 2: Context + Rate Limits (Ring Meter) ---
CTX_RING=$(ring_meter "$PCT")
printf '%b' "Context: ${CTX_COLOR}${CTX_RING} ${PCT}%${RESET}"

if [ "$FIVE_PCT" -ge 0 ]; then
  FIVE_COLOR=$(pct_color "$FIVE_PCT")
  FIVE_RING=$(ring_meter "$FIVE_PCT")
  FIVE_RESET_FMT=$(format_reset_time "$FIVE_RESET")

  printf '%b' " | Session: ${FIVE_COLOR}${FIVE_RING} ${FIVE_PCT}%${RESET}"
  [ -n "$FIVE_RESET_FMT" ] && printf '%b' " ${DIM}(${FIVE_RESET_FMT})${RESET}"
else
  printf '%b' " | Session: ${DIM}○ ---%${RESET}"
fi

if [ "$SEVEN_PCT" -ge 0 ]; then
  SEVEN_COLOR=$(pct_color "$SEVEN_PCT")
  SEVEN_RING=$(ring_meter "$SEVEN_PCT")
  SEVEN_RESET_FMT=$(format_reset_time "$SEVEN_RESET")

  printf '%b' " | Week: ${SEVEN_COLOR}${SEVEN_RING} ${SEVEN_PCT}%${RESET}"
  [ -n "$SEVEN_RESET_FMT" ] && printf '%b' " ${DIM}(${SEVEN_RESET_FMT})${RESET}"
else
  printf '%b' " | Week: ${DIM}○ ---%${RESET}"
fi
printf '\n'
