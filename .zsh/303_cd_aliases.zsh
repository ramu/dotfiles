#!/bin/zsh
# alias - cd
for i in {0..8}; do
   _DOTS="..`repeat $i echo -n '.'`"
   _DOTSPATH=`repeat $i echo -n "/.."`
   alias $_DOTS="cd ..${_DOTSPATH}"
done
alias cdc='cd ~/work/c/'
alias cdd='cd ~/dotfiles/'
alias cdD='cd ~/Downloads/'
alias cdg='cd ~/work/git/'
alias cdh='cd ~/work/haskell/'
alias cdj='cd ~/work/javascript/'
alias cdjava='cd ~/work/java/'
alias cdm='cd ~/work/mercurial/'
alias cdr='cd ~/work/ruby/'
alias cdra='cd ~/work/ruby/rails/'
alias cdt='cd ~/work/topcoder/'
alias cdp='cd ~/work/python/'
alias cdpe='cd ~/work/perl/'
alias cdw='cd ~/work/'
alias cdz='cd ~/.zsh/'

