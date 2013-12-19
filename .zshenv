#!/bin/zsh
ZDOTDIR=~/.zsh
UNAME=`uname`

# emacs configuration
if [[ $EMACS = "t" ]]; then
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

# screen
if [[ $TERM != "screen-256color" && $EMACS != "t" ]]; then
    tmux
fi

