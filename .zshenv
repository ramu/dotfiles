#!/bin/zsh
ZDOTDIR=~/.zsh
HISTFILE=~/log/.zsh_history/.zsh_history
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

# herdr
# 非対話シェル/TTY なしで起動すると herdr が panic するため必ずガードする
if [[ -o interactive && -t 1 && $HERDR_ENV != "1" && $EMACS = "" && $IDEA_INITIAL_DIRECTORY = "" && $TERM_PROGRAM != "vscode" ]]; then
    herdr
fi

