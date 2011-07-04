#!/bin/zsh
# alias
alias clean='rm -f *~'
alias df='df -H'
alias ebc='emacs -batch -f batch-byte-compile'
alias ei='easy_install'
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
## g ##
alias ga='git add'
alias gau='git add -u'
alias gaa='git add -A'
alias gbr='git branch -v'
alias gbrd='git branch -d'
alias gbl='git blame'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcl='git clone'
alias gcm='git checkout master'
alias gco='git commit -v'
alias gcoa='git commit -a -v'
alias gcoam='git commit -a -m'
alias gcom='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gh='git help'
alias gi='git init'
alias gis='git --bare init --shared'
alias gl='git log --graph --decorate --pretty=format:"%ad [%cn] <c:%h t:%t p:%p> %n %Cgreen%d%Creset %s %n" --stat -p'
alias gm='git merge'
alias gp='git push'
alias gpu='git pull'
alias gres='git reset'
alias gresh='git reset HEAD'
alias greb='git rebase'
alias grep='grep --color=auto'
alias grev='git revert'
alias gs='git status -sb'
alias gserve='git instaweb'
alias gsh='git show'
alias gshb='git show-branch'
alias gt='git tag'
alias gtl='git tag -l -n'
## h ##
alias ha='hg add'
alias han='hg annotate -u -n -c -l'
alias har='hg archive'
alias hb='hg branch'
alias hbs='hg branches'
alias hc='hg cat'
alias hco='hg commit'             # hg copy...
alias hcom='hg commit -m'
alias hcl='hg clone'
alias hd='hg diff'
alias hh='hg heads'
alias hi='hg init'
alias history='history 1'
alias hl='hg log -p'
alias hm='hg merge'
alias hp='hg push'
alias hpa='hg parents'
alias hpu='hg pull'
alias hr='hg rollback'
alias hrem='hg remove'
alias hren='hg rename'
alias hres='hg resolve'
alias hrev='hg revert'
alias hs='hg status'
alias hsc='hg showconfig'
alias hserve='hg serve'
alias ht='hg tag'
alias hu='hg update'
## i ##
alias ip='ifconfig | grep "inet "'
alias javac='javac -J-Dfile.encoding=UTF8'
alias ls='ls -AFG'
alias ll='ls -lG'
alias lll='ll'
alias mv='mv'
alias mkdir='nocorrect mkdir'
alias pb='pythonbrew'
alias pbl='pythonbrew list'
alias pbs='pythonbrew switch'
alias ps='ps aux'
alias pd='popd'
alias reload='source ${HOME}/.zshrc'
alias rm='rm -f'
alias scala='scala -classpath .' 
alias seq='gseq'
alias tig='tig --all'
alias val='valgrind'
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
alias wcat='wget -q -O -'
alias zmv='noglob zmv -W'

### +g(command_name)
alias objdump='gobjdump'
alias libtoolize='glibtoolize'

### Directory Bookmarks
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias lma='alias | grep -e "g[0-9]=" | grep -v "m[0-9]" | sed "s/^g/alias g/g"'

### numbers(chmod)
alias 644='chmod 644'
alias 755='chmod 755'
alias 777='chmod 777'

