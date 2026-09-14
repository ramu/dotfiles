#!/bin/bash
# claude -p (パイプモード) 検出ヘルパー
# プロセスツリーを遡り、claude が -p/--print 付きで起動されたか判定する
# source して is_pipe_mode 関数として使う、または直接実行して終了コードで判定
#
# 使用例:
#   source ~/.claude/scripts/is-pipe-mode.sh
#   if is_pipe_mode; then echo "pipe mode"; fi
#
#   または: ~/.claude/scripts/is-pipe-mode.sh && echo "pipe mode"

is_pipe_mode() {
    local pid=$$
    local args cmd
    while [[ "$pid" =~ ^[0-9]+$ ]] && [ "$pid" -gt 1 ]; do
        args=$(ps -o args= -p "$pid" 2>/dev/null)
        # 実行ファイル名が claude であることを確かめてから -p を探す。
        # 引数のどこかに claude という文字列があるだけで判定すると、
        # Claude Code が起動するシェルの引数には常に ~/.claude/... が含まれるため、
        # 無関係な -p (mkdir -p 等) を拾って誤判定する。
        cmd="${args%% *}"
        if [ "${cmd##*/}" = "claude" ] && [[ "$args" =~ (^|[[:space:]])(-p|--print)([[:space:]]|$) ]]; then
            return 0
        fi
        pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
        [ -z "$pid" ] && return 1
    done
    return 1
}

# 直接実行された場合は結果を終了コードで返す
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    is_pipe_mode
fi
