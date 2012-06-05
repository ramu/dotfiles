#!/bin/zsh
# path
PATH=/Users/ramusara/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/opt/local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/sbin
PATH=$PATH:/Users/ramusara/scala/bin
PATH=$PATH:/Users/ramusara/Android/android-ndk-r5b
PATH=$PATH:/Library/Java/ant/bin
PATH=/Users/ramusara/.rbenv/bin:$PATH

eval "$(rbenv init -)"
source /usr/local/Cellar/rbenv/0.3.0/completions/rbenv.zsh
