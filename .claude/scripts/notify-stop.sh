#!/bin/bash
# デバウンス付き Stop 通知スクリプト
# 連続する Stop イベント（サブエージェント終了等）をまとめ、
# 最後の Stop から一定時間経過後に1回だけ通知する

# claude -p (パイプモード) での実行時は通知を抑制
source "$(dirname "$0")/is-pipe-mode.sh"

if is_pipe_mode || [ "${CLAUDE_NO_NOTIFY:-}" = "1" ]; then
    exit 0
fi

DEBOUNCE_SECONDS=3
PID_FILE="/tmp/claude-code-notify-stop.pid"

# 前回の保留中の通知をキャンセル
if [ -f "$PID_FILE" ]; then
    old_pid=$(cat "$PID_FILE" 2>/dev/null)
    kill "$old_pid" 2>/dev/null
    rm -f "$PID_FILE"
fi

# 遅延通知をバックグラウンドでスケジュール
dir_name=$(basename "$PWD")
(
    sleep "$DEBOUNCE_SECONDS"
    osascript -e "display notification \"タスクが完了しました\" with title \"${dir_name}\" sound name \"Glass\""
    rm -f "$PID_FILE"
) &

# バックグラウンドプロセスの PID を保存
echo $! > "$PID_FILE"
