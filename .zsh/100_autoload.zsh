#!/bin/zsh
# autoload
autoload -Uz colors
autoload -Uz is-at-least
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz zmv
autoload -U promptinit
# compinit / bashcompinit はここでは宣言だけに留める。
# ここで compinit を実行すると -d が効かず $ZDOTDIR (= dotfiles) へダンプが書かれるため、
# 実行は出力先を指定できる 106_complete.zsh に集約する。
autoload -Uz compinit
autoload -Uz bashcompinit

fpath=($HOME/.zsh/modules/cd-gitroot(N-/) $fpath)
autoload -Uz cd-gitroot
