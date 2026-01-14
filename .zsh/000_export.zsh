#!/bin/zsh
# export

if [ `uname` = "Darwin" ]; then
export EDITOR=/usr/local/bin/vim
elif [ `uname` = "Linux" ]; then
export EDITOR=/bin/vi
fi

export LANG=ja_JP.UTF-8
export TZ='JST-9'

export GOPATH=$HOME_DIR

export RIPGREP_CONFIG_PATH=$HOME_DIR/.ripgreprc

