#!/bin/zsh

HOME_DIR=~

# path
PATH=$HOME_DIR/bin
PATH=$HOME_DIR/.rbenv/bin:$PATH
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/opt/local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:$HOME_DIR/scala/bin
PATH=$PATH:$HOME_DIR/Android/android-ndk-r5b
PATH=$PATH:$HOME_DIR/Library/Android/sdk/tools
PATH=$PATH:$HOME_DIR/Library/Android/sdk/platform-tools
PATH=$PATH:/Applications/sdk/tools
PATH=$PATH:/Applications/sdk/platform-tools
PATH=$PATH:$HOME_DIR/work/google/flutter/flutter/bin
PATH=$PATH:/Library/Java/ant/bin
PATH=$PATH:/usr/share/grails/bin
PATH=$PATH:/usr/share/griffon/bin
PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
PATH=$PATH:$GOPATH/bin
PATH=$HOME_DIR/work/gae/go_engine:$PATH
PATH=$HOME_DIR/work/java/maven/bin:$PATH
PATH=/usr/local/heroku/bin:$PATH
PATH=/Applications/MAMP/bin/php/php5.4.10/bin:$PATH

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"
source /usr/local/Cellar/rbenv/1.1.2/completions/rbenv.zsh

# direnv
eval "$(direnv hook zsh)"

# nodenv
eval "$(nodenv init -)"
PATH=$PATH:`npm bin -g`
