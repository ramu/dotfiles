#!/bin/zsh
# functions
#-----------------------------------------------------------
# mkdir && ls
function mkcd() { mkdir $1 && cd $1 }

#-----------------------------------------------------------
# cd && ls
#    function cd() {builtin cd $@ && ls -aF --show-control-char --color=auto}
function chpwd() {
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command ls -AqCFG | sed $'/^\e\[[0-9;]*m$/d')
  ls_lines=`echo "$ls_result" | wc -l | tr -d ' '`
  if [ $ls_lines -gt 10 ]; then
    echo "$ls_result" | head -n 5
    echo "..."
    echo "$ls_result" | tail -n 5
    echo "$ls_lines files exist"
  else
    echo "$ls_result"
  fi
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

#------------------------------------------------------------
# cdup
fucntion cdup () {
  echo
  cd ..
  zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

#------------------------------------------------------------
# Invoke the dired of current working directory in Emacs buffer.
function dired () {
  emacsclient -e "(dired \"$PWD\")"
}

#------------------------------------------------------------
# Chdir to the default-directory of currently opened in Emacs buffer.
function cde () {
  EMACS_CWD=`emacsclient -e "
    (expand-file-name
      (with-current-buffer
        (if (featurep 'elscreen)
            (let* ((frame-confs (elscreen-get-frame-confs (selected-frame)))
                   (num (nth 1 (assoc 'screen-history frame-confs)))
                   (cur-window-conf (cadr (assoc num (assoc 'screen-property frame-confs))))
                   (marker (nth 2 cur-window-conf)))
              (marker-buffer marker))
         (nth 1
           (assoc 'buffer-list
             (nth 1 (nth 1 (current-frame-configuration))))))
     default-directory))" | sed 's/^"\(.*\)"$/\1/'`

  echo "chdir to $EMACS_CWD"
  cd "$EMACS_CWD"
}

#------------------------------------------------------------
# gem install/uninstall + rehash
function gem() {
  $HOME/.rbenv/shims/gem $*
  if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
  then
    rbenv rehash
    rehash
  fi
}

#-----------------------------------------------------------
# mkdir && git init
function mkdir_git_init() { mkdir $1 && cd $1 && git init }

#-----------------------------------------------------------
# rails new $1 --skip-bundle + cd $1
rails-new--skip-bundle() {
   rails new $1 --skip-bundle
   cd $1
}

