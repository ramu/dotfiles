#!/bin/zsh
ZDOTDIR=~/.zsh

# Load configuration(.zsh)
for rc in $ZDOTDIR/*.zsh
do
   source $rc
done
unset rc

