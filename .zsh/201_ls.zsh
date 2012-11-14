#!/bin/zsh
# ls
export LSCOLORS=exfxcxdxbxegedabagacad
zstyle ':completion:*' list-colors ''

# 補完候補が多い時に下記値より多くない場合は確認メッセージ出さない
LISTMAX=10000

# ls /usr/local/etcなどを以下のようにC-wで単語毎に削除
#   default : ls /usr/local ---> ls /usr/ ---> ls /usr ---> / 
#   この設定: ls /usr/local ---> ls /usr/ ---> ls 
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

