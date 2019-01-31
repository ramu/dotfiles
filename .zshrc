#!/bin/zsh
ZDOTDIR=~/.zsh
UNAME=`uname`

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then source '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

