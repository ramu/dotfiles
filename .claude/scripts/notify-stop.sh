#!/bin/bash
# デバウンス付き Stop 通知スクリプト
# 連続する Stop イベント（サブエージェント終了等）をまとめ、
# 最後の Stop から一定時間経過後に1回だけ通知する

# フック入力の JSON は session_id の取得にだけ使う
hook_input=$(cat 2>/dev/null)

# claude -p (パイプモード) での実行時は通知を抑制
source "$(dirname "$0")/is-pipe-mode.sh"

if is_pipe_mode || [ "${CLAUDE_NO_NOTIFY:-}" = "1" ]; then
    exit 0
fi

DEBOUNCE_SECONDS=3

# デバウンス用の PID ファイルはセッションごとに分ける。
# 共有すると、herdr で複数ペインを並行運用したときに別ペインの保留中の通知まで
# キャンセルしてしまい、通知が届かないペインが出る。
session_key=""
if [ -n "$hook_input" ] && command -v jq >/dev/null 2>&1; then
    session_key=$(printf '%s' "$hook_input" | jq -r '.session_id // empty' 2>/dev/null)
fi
[ -n "$session_key" ] || session_key="${HERDR_PANE_ID:-}"
[ -n "$session_key" ] || session_key="$PPID"
session_key=$(printf '%s' "$session_key" | tr -c '[:alnum:]._-' '_')

PID_FILE="${TMPDIR:-/tmp}/claude-code-notify-stop.${session_key}.pid"
SCRIPT_NAME=$(basename "$0")

# 前回の保留中の通知をキャンセルする。
# PID が使い回されていた場合に無関係なプロセスを落とさないよう、
# 対象がこのスクリプト自身であることを確かめてから止める。
if [ -f "$PID_FILE" ]; then
    old_pid=$(cat "$PID_FILE" 2>/dev/null)
    if [[ "$old_pid" =~ ^[0-9]+$ ]] && ps -o command= -p "$old_pid" 2>/dev/null | grep -q "$SCRIPT_NAME"; then
        kill "$old_pid" 2>/dev/null
    fi
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
