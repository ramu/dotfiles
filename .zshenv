#!/bin/zsh
ZDOTDIR=~/.zsh

# emacs configuration
if [[ $EMACS = "t" ]]; then
    unsetopt zle
    export PATH=""
fi

# Load configuration(.zsh)
for rc in $ZDOTDIR/*.zsh
do
    source $rc
done
unset rc

# screen
if [[ $TERM != "screen" && $EMACS != "t" ]]; then
    screen
fi

