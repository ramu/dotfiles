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

    printf '%b' "📁 ${DIR##*/} | 🌿 ${CYAN}${BRANCH}${RESET} ${GIT_STATUS}\n"
else
    printf '%b' "📁 ${DIR##*/}\n"
fi
