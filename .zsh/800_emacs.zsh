#!/bin/zsh
# emacs
# Emacs key bindings
bindkey -e

[[ $TERM = "eterm-color" ]] && TERM=xterm-color

emacs_daemon_count=`ps | grep 'Emacs' | grep ' --daemon' | grep -v grep | wc -l | tr -d ' '`
if [ $emacs_daemon_count -gt 0 ]; then
  emacsclient -e '(kill-emacs)'
fi
