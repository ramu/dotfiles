#!/bin/zsh
# history
HISTFILE=~/log/.zsh_history/.zsh_history
SAVEHIST=10000000
HISTSIZE=10000000
DIRSTACKSIZE=30

# commandline stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack
