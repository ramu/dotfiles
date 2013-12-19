#!/bin/zsh
# export 
export ANDROIDNDK_HOME=/Users/ramusara/Android/android-ndk-r5b
if [ `uname` = "Darwin" ]; then
export EDITOR=/usr/local/bin/vim
elif [ `uname` = "Linux" ]; then
export EDITOR=/bin/vi
fi
export JAVA_OPTS="-XstartOnFirstThread -d32 -Dfile.encoding=UTF-8"
export LANG=ja_JP.UTF-8
export TZ='JST-9'
export JUNIT_HOME='/usr/local/java/junit/'
export CLASSPATH="${CLASSPATH}:$JUNIT_HOME/junit.jar"
export RSENSE_HOME='/opt/rsense/'

export VIRTUALENV_USE_DISTRIBUTE=true
