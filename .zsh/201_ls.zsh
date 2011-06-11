#!/bin/zsh
# ls
export LSCOLORS=exfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors ''

# ls /usr/local/etcなどを以下のようにC-wで単語毎に削除
#   default : ls /usr/local ---> ls /usr/ ---> ls /usr ---> / 
#   この設定: ls /usr/local ---> ls /usr/ ---> ls 
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

