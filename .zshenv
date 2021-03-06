#!/bin/zsh
ZDOTDIR=~/.zsh
UNAME=`uname`

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

# tmux
if [[ $TERM != "screen-256color" && $EMACS = "" ]]; then
    tmux
fi

