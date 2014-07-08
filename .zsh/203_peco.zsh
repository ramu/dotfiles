#!/bin/zsh

function peco-function-list() {
  local selected=$(functions | grep "^.*\ ()\ {" | sed -e "s| () {||" | grep peco- | grep -v function-list | peco --query "$LBUFFER")
  if [ -n "$selected" ]; then
    ${selected}
  fi
}
zle -N peco-function-list
bindkey '^x^p' peco-function-list

function peco-select-history() {
  BUFFER=$(\history -n 1 | eval "tail -r" | peco --query "$LBUFFER")
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
