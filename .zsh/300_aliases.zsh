#!/bin/zsh
# alias
alias bi='brew install'
alias bs='brew search'
alias clean='rm -f *~'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dce='docker-compose exec'
alias dcl='docker-compose logs -f -t --tail=20'
alias dcr='docker-compose run --rm'
alias df='df -H'
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
alias ebc='emacs -batch -f batch-byte-compile'
alias ei='easy_install'
if [ `uname` = "Darwin" ]; then
  alias emacs='TERM=xterm-256color /Applications/Emacs.app/Contents/MacOS/Emacs -nw'
  alias emacsclient='TERM=xterm-256color /Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw'
  alias ec='emacsclient'
fi
alias fd='fd -HI'
## g ##
alias ga='git add'
alias gau='git add -u'
alias gaa='git add -A'
alias gap='git add -p'
alias gbr='git branch -v'
alias gbrd='git branch -d'
alias gbl='git blame'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcl='git clone'
alias gcm='git checkout `git remote show origin | sed -n "/HEAD branch/s/.*: //p"`'
alias gco='git commit -v'
alias gcoa='git commit -a -v'
alias gcoam='git commit -a -m'
alias gcom='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
# gh is GitHub CLI
alias gi='mkdir_git_init'
alias gih='git init'
alias gis='git --bare init --shared'
alias gl="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"
alias gm='git merge'
alias gp='git push --force-with-lease'
alias gpf='git_push_force_origin'
alias gphm='git push heroku master'
alias gpod='git pull origin develop'
alias gpu='git pull'
alias gres='git reset'
alias gresh='git reset HEAD'
alias greb='git rebase'
alias grep='grep --color=auto'
alias grev='git revert'
alias grid='git rebase -i develop'
alias grim='git rebase -i `git remote show origin | sed -n "/HEAD branch/s/.*: //p"`'
alias gs='git status -sb && git stash list'
alias gsd='git stash drop'
alias gserve='git instaweb'
alias gsh='git show'
alias gshb='git show-branch'
alias gsp='git stash pop'
alias gsu='git stash save -u'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch `git remote show origin | sed -n "/HEAD branch/s/.*: //p"`'
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
alias hl='hg glog -p'
alias hlt='heroku logs --tail'
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
alias httpserver='ruby -run -e httpd . -p 8080'
alias hu='hg update'
## i ##
alias ip='ifconfig | grep "inet "'
alias javac='javac -J-Dfile.encoding=UTF8'
alias k9='kill -9'
alias ls='lsd -AF'
alias ll='ls -l'
alias lll='ll'
alias mv='mv'
alias mkdir='nocorrect mkdir'
alias mux="tmuxinator"
alias openpr='git browse-remote --pr'
alias pb='pythonbrew'
alias pbl='pythonbrew list'
alias pbs='pythonbrew switch'
alias pipf='pip freeze -l'
alias pipi='pip install'
alias pips='pip search'
alias prmerge='git_pull_request_merge'
alias ps='ps aux'
alias pd='popd'
alias pull='git pull'
alias push='git push'
alias rc='rails console'
alias rdc='rails destroy controller'
alias rdm='rails destroy model'
alias rds='rails destroy scaffold'
alias reload='source ${HOME}/.zshrc'
alias replace='replace'
# alias rg='rails generate'   ripgrep 使うので無効
alias rgc='rails generate controller'
alias rgm='rails generate model'
alias rgmi='rails generate migration'
alias rgr='rails generate resource'
alias rgs='rails generate scaffold'
alias rm='rm -f'
alias rmigc='rake db:migrate db:test:clone'
alias rn='rails-new-and-git-setup'
alias rns='rails-new--skip-bundle'
alias rr='rake routes'
alias rs='rails server'
alias scala='scala -classpath .' 
alias seq='gseq'
alias srs='spring rails s'
alias tig='tig --all'
alias tree='ls --tree'
alias tspon='tmux set-window-option synchronize-panes on'
alias tspoff='tmux set-window-option synchronize-panes off'
alias val='valgrind'
alias wcat='wget -q -O -'
alias wip='git_wip'
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
