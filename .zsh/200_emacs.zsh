#!/bin/zsh
# emacs
# Emacs key bindings
bindkey -e

[[ $TERM = "eterm-color" ]] && TERM=xterm-color


emacsclient -e '(kill-emacs)'
emacs --daemon
