#!/bin/zsh

function peco-function-list() {
  local selected=$(functions | grep "^.*\ ()\ {" | sed -e "s| () {||" | grep peco- | grep -v function-list | peco --query "$LBUFFER")
  if [ -n "$selected" ]; then
    ${selected}
  fi
}
zle -N peco-function-list
bindkey '^x^p' peco-function-list

# 履歴は herdr の pane ごとに別ファイルへ分かれている (105_history.zsh)。
# 矢印キーの履歴遡りは自 pane に閉じるが、^R では全 pane + 過去のグローバル履歴を横断する。
function peco-select-history() {
  local -a files
  files=($ZSH_HIST_DIR/.zsh_history(N) $ZSH_HIST_DIR/herdr-*.history(N))
  if (( ${#files} == 0 )); then
    BUFFER=$(\history -n 1 | eval "tail -r" | peco --query "$LBUFFER")
  else
    local entries
    # 履歴ファイルは不正なマルチバイト列を含みうるので、抽出は LC_ALL=C で行う
    entries=$(
      export LC_ALL=C
      # extended_history の ": <開始時刻>:<所要秒>;<コマンド>" から時刻とコマンドを取り出し、
      # 新しい順に並べ替えてから重複を落とす
      sed -nE 's/^: ([0-9]+):[0-9]+;(.*)$/\1\t\2/p' $files \
        | sort -s -rn -k1,1 \
        | cut -f2- \
        | awk '!seen[$0]++' \
        | perl -pe 's/\x83(.)/chr(ord($1)^32)/ge'  # zsh のメタ化 (0x83 + 元バイト^0x20) を戻す
    )
    # peco は日本語の表示幅計算にロケールを使うため LC_ALL=C の外で動かす
    BUFFER=$(print -r -- "$entries" | peco --query "$LBUFFER")
  fi
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-killproc() {
  ps -o pid,lstart,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
  zle clear-screen
}
zle -N peco-killproc
bindkey '^x^k' peco-killproc
