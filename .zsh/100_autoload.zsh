#!/bin/zsh
# autoload
autoload -Uz colors
autoload -Uz is-at-least
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz zmv
autoload -U promptinit
autoload compinit
compinit -u

fpath=($HOME/.zsh/modules/cd-gitroot(N-/) $fpath)
autoload -Uz cd-gitroot
