#!/bin/zsh
# history
# ZSH_HIST_DIR と HISTFILE (herdr の pane ごとの切り替えを含む) は .zshenv で確定させている。
# 履歴の出力先だけは $ZDOTDIR の読み込みより前に決める必要があるため、ここには置かない。
SAVEHIST=10000000
HISTSIZE=10000000
DIRSTACKSIZE=30

# 閉じた pane の履歴ファイルは残り続けるため、古いものをグローバル履歴へ集約する。
# ^R の横断検索が開くファイル数を抑えるのが目的で、履歴の中身自体は失わない。
ZSH_HIST_COMPACT_DAYS=${ZSH_HIST_COMPACT_DAYS:-30}
_zsh_history_compact() {
  # ZSH_HIST_DIR は .zshenv でしか設定されない。reload (source ~/.zshrc) のように
  # .zshenv を経由せずここだけ読み直す経路では未設定になり、/ へ書きに行ってしまう。
  [[ -d $ZSH_HIST_DIR ]] || return
  local lock=$ZSH_HIST_DIR/.compact.lock
  local f
  zmodload -F zsh/system b:zsystem 2>/dev/null || return
  # zsystem flock は対象ファイルが無いと失敗するため、先に用意しておく
  [[ -f $lock ]] || : >>! $lock 2>/dev/null || return
  # 他の pane が集約中なら何もしない (グローバル履歴への二重追記を防ぐ)
  zsystem flock -t 0 $lock 2>/dev/null || return
  for f in $ZSH_HIST_DIR/herdr-*.history(N.md+${ZSH_HIST_COMPACT_DAYS}); do
    [[ $f == $HISTFILE ]] && continue
    # 追記に成功したときだけ元ファイルを片付ける
    cat -- $f >> $ZSH_HIST_DIR/.zsh_history || continue
    if (( $+commands[trash] )); then
      trash -- $f 2>/dev/null || command rm -f -- $f
    else
      command rm -f -- $f
    fi
  done
}
if [[ -n $HERDR_PANE_ID ]]; then
  # シェル起動を待たせないようバックグラウンドへ逃がす
  { _zsh_history_compact } &!
fi

# commandline stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack
