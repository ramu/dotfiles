#!/bin/zsh

HOME_DIR=~

# path
PATH=$HOME_DIR/bin
PATH=$HOME_DIR/.local/bin:$PATH
PATH=$HOME_DIR/.rbenv/bin:$PATH
PATH=$HOME_DIR/.rbenv/shims:$PATH
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/opt/local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
PATH=$PATH:$GOPATH/bin

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# rbenv
export RBENV_ROOT=/opt/homebrew/Cellar/rbenv
eval "$(rbenv init -)"
FPATH=$RBENV_ROOT/1.3.2/completions:$FPATH

# direnv
eval "$(direnv hook zsh)"

# nodenv
eval "$(nodenv init -)"
PATH=$PATH:$HOME_DIR/.nodenv/shims

# mise
eval "$(mise activate zsh)"

