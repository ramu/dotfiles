#!/bin/zsh
# fzf functions

#-----------------------------------------------------------
# https://github.com/junegunn/fzf/wiki/Examples#general
# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extension mp3
# fm rm # To rm files in current directory
f() {
  sels=( "${(@f)$(fd --hidden --no-ignore --exclude .git "${@:2}" | fzf --preview='bat --color=always {}')}" )
  test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}
# Like f, but not recursive.
fm() {
  f "$@" --max-depth 1
}

#-----------------------------------------------------------
# https://github.com/junegunn/fzf/wiki/Examples#changing-directory
# fcd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/.git' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

#-----------------------------------------------------------
# fv - fzf + vim
fv() {
  local files
  files=( "${(@f)$(fd --hidden --no-ignore --exclude .git "${@}" | fzf --preview='bat --color=always {}' --multi)}" )
  [[ -n "$files" ]] && vim -- "${files[@]}"
}

#-----------------------------------------------------------
# frg - fzf + rg
# ※ fg という名前は既存コマンドと被るので使えません
frg() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: frg <pattern>"
    return 1
  fi
  rg --no-heading --line-number $@ | fzf -0 -1 --preview='bat --color=always --highlight-line {2} {1}' --preview-window='+{2}-5' --delimiter=:
}

#-----------------------------------------------------------
# fgv - fzf + rg + vim
fgv() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: fgv <pattern>"
    return 1
  fi
  local file line
  read -r file line <<<"$(rg --no-heading --line-number $@ | fzf -0 -1 --preview='bat --color=always --highlight-line {2} {1}' --preview-window='+{2}-5' --delimiter=: | awk -F: '{print $1, $2}')"
  [[ -n $file ]] && vim $file +$line
}

#-----------------------------------------------------------
# https://github.com/junegunn/fzf/wiki/Examples#command-history
# fh - fzf + history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

#-----------------------------------------------------------
# https://github.com/junegunn/fzf/wiki/Examples#processes
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(command ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(command ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

#-----------------------------------------------------------
# https://github.com/junegunn/fzf/wiki/Examples#git
# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ refs/remotes/ \
             --format="%(refname:short)" | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf +m) &&
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git switch "$branch"
  else
    git switch "${branch#*/}"
  fi
}

#-----------------------------------------------------------
# ftpane - fzf + tmux switch pane 
ftpane() {
  local cur sel id
  cur=$(tmux display-message -p '#I.#P')
  sel=$(tmux list-panes -s -F '#I.#P [#W] #{pane_current_path} #{pane_current_command}' \
    | grep -v "^$cur " | fzf +m) || return
  id=${sel%% *}
  tmux select-pane -t "$id" && tmux select-window -t "${id%%.*}"
}

#-----------------------------------------------------------
# fgqh - fzf + ghq 
fghq() {
  local repo
  repo=$(ghq list | fzf --preview "command ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'") &&
  cd "$(ghq root)/$repo"
}

