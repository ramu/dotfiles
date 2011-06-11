#!/bin/zsh
# functions
#-----------------------------------------------------------
# mkdir && ls
function mkcd() { mkdir $1 && cd $1 }

#-----------------------------------------------------------
# cd && ls
#    function cd() {builtin cd $@ && ls -aF --show-control-char --color=auto}
function cd() {
  if [ $# = 0 ]; then
    builtin cd
  elif [ -f $1 ]; then
    builtin cd $1:h
  else
    builtin cd $*
  fi
  ls -AFG
}

#-----------------------------------------------------------
# accept-line-with-url
# http://sugi.nemui.org/doc/zsh/#doc2_14
#    プロンプトにURLを打ち込んでブラウザ表示／ダウンロード可能
# 変数:WWW_BROWSER, DOWNLOADER, browse_or_download_method
browse_or_download_method="auto" # ask, auto, download, browse
fpath=(~/.zsh $fpath)            # zsh function Directory
if autoload +X -U _accept_line_with_url > /dev/null 2>&1; then
  zle -N accept-line-with-url _accept_line_with_url
  bindkey '^M' accept-line-with-url
fi

#------------------------------------------------------------
function redrev() {
  perl -pe 's/^/\e[41m/ && s/$/\e[m/';
}
alias -g RED='2> >(redrev)'

#------------------------------------------------------------
# test ---> ./test
#function command_not_found_handler() {
#   echo "(zsh: command not found: $0 ---> ./$0)"
#   ./$0
#}

