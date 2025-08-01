#!/bin/zsh
# export 
export ANDROIDNDK_HOME=$HOME_DIR/Android/android-ndk-r5b
export ANDROID_SDK=/Applications/sdk
export ANDROID_TOOLS=/Applications/sdk/tools

if [ `uname` = "Darwin" ]; then
export EDITOR=/usr/local/bin/vim
elif [ `uname` = "Linux" ]; then
export EDITOR=/bin/vi
fi

export LANG=ja_JP.UTF-8
export TZ='JST-9'
export JUNIT_HOME='/usr/local/java/junit/'
export CLASSPATH="${CLASSPATH}:$JUNIT_HOME/junit.jar"
export RSENSE_HOME='/opt/rsense/'

export VIRTUALENV_USE_DISTRIBUTE=true

export GOPATH=$HOME_DIR

export RIPGREP_CONFIG_PATH=$HOME_DIR/.ripgreprc

