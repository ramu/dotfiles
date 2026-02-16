#!/bin/bash
# Notification フック: 許可リクエスト時の通知
# claude -p (パイプモード) での実行時は通知を抑制

source "$(dirname "$0")/is-pipe-mode.sh"

if is_pipe_mode || [ "${CLAUDE_NO_NOTIFY:-}" = "1" ]; then
    exit 0
fi

osascript -e 'display notification "Claude Codeが許可を求めています" with title "Claude Code" sound name "Glass"'
