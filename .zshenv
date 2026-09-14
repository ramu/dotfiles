#!/bin/zsh
ZDOTDIR=~/.zsh
UNAME=`uname`

# zsh の生成物 (履歴・補完ダンプ・補完キャッシュ) の置き場。
# ZDOTDIR=~/.zsh は dotfiles リポジトリへのシンボリックリンクなので、既定のまま
# $ZDOTDIR 配下へ書かせるとリポジトリが生成物で汚れる。
# 履歴の出力先は $ZDOTDIR/*.zsh の読み込みを待たずにここで確定させる。
# 後ろの設定に任せると、そこへ到達しない起動経路で /etc/zshrc の
# HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history が生き残り、~/.zsh/.zsh_history へ書かれてしまう。
ZSH_STATE_DIR=~/log/zsh
ZSH_HIST_DIR=$ZSH_STATE_DIR/history
# setup.sh を流していないマシンでも履歴と補完ダンプを書けるようにしておく
[[ -d $ZSH_HIST_DIR ]] || mkdir -p $ZSH_HIST_DIR
if [[ -n $HERDR_PANE_ID ]]; then
  # herdr の pane ごとに履歴を分ける。
  # 全 pane が同じ HISTFILE を共有すると、zsh は終了時にファイルを丸ごと上書きするため、
  # 同時に開いていた他 pane の履歴が失われる。
  # HERDR_PANE_ID は "w4:p1" 形式。':' はファイル名に使えるが表示が崩れるので '-' に置換する
  HISTFILE=$ZSH_HIST_DIR/herdr-${HERDR_PANE_ID//:/-}.history
else
  HISTFILE=$ZSH_HIST_DIR/.zsh_history
fi

setopt no_global_rcs

# emacs configuration
if [[ "$EMACS" != "" ]]; then
    unsetopt zle
    export PATH=""
fi

# Load common configuration
for rc in $ZDOTDIR/*.zsh
do
    source $rc
done
unset rc

# Load os configuration
if [ -d $ZDOTDIR/$UNAME ]; then
    for rc in $ZDOTDIR/$UNAME/*.zsh
    do
        source $rc
    done
    unset rc
fi

# herdr
# 非対話シェル/TTY なしで起動すると herdr が panic するため必ずガードする
if [[ -o interactive && -t 1 && $HERDR_ENV != "1" && $EMACS = "" && $IDEA_INITIAL_DIRECTORY = "" && $TERM_PROGRAM != "vscode" ]]; then
    herdr
fi

