#!/bin/zsh
# functions
#-----------------------------------------------------------
# mkdir && ls
function take() { mkdir -p $1 && cd $1 }

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
function cdup () {
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
  #~/.rbenv/shims/gem $*
  /opt/homebrew/Cellar/rbenv/shims/gem $*
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

#-----------------------------------------------------------
# rails new $1 + cd $1 + git init/add/commit
rails-new-and-git-setup() {
   rails new $1
   cd $1
   git init
   git add .
   git commit -m 'Initialize repository'
}

#-----------------------------------------------------------
# wip
function git_wip() {
  current=`git rev-parse --abbrev-ref HEAD`
  git switch -c $1
  git commit --allow-empty -m "NOPR: [ci skip]"
  git push origin $1
  git branch -u origin/$1 $1
  gh pr create --base $current --draft --assignee "@me"
}

#-----------------------------------------------------------
# git push --force origin {current_branch}
function git_push_force_origin() {
  current=`git rev-parse --abbrev-ref HEAD`
  git push --force-with-lease origin $current
}

#-----------------------------------------------------------
# github pull-request merge
function git_pull_request_merge() {
  parent_branch_hash=`git log --decorate | grep 'commit' | grep 'origin/' | head -n 2 | tail -n 1 | awk '{ print $2 }' | tr -d "\n"`
  parent_branch_name=`git name-rev $parent_branch_hash | awk '{ print $2 }'`
  current_branch_name=`git rev-parse --abbrev-ref HEAD`

  echo '[' $current_branch_name '] ===> [' $parent_branch_name '] merge? (y/n)'
  read answer
  case $answer in
    y)
      git switch $parent_branch_name
      git merge --no-ff $current_branch_name
      git push
      ;;
    *)
      echo -e "cancel pull-request merge.\n"
      ;;
  esac
}

#-----------------------------------------------------------
# replace $1 $2
function replace() {
  rg -l --hidden "$1" | xargs -n 1 gsed -i "s/$1/$2/g"
}

#-----------------------------------------------------------
# git worktree functions

# git worktree 作成(ブランチの有無を判別してコマンド分岐)
function git_worktree_add() {
  local branch_name=$1

  if [ -z "$branch_name" ]; then
    echo "Usage: git_worktree_add <branch-name>"
    return 1
  fi

  # ブランチが存在するか確認してコマンドを分岐
  if git show-ref --verify --quiet "refs/heads/${branch_name}"; then
    # 既存ブランチ
    echo "Checking out existing branch: ${branch_name}"
    git worktree add "../${branch_name}" "${branch_name}"
  else
    # 新規ブランチ
    echo "Creating new branch: ${branch_name}"
    git worktree add "../${branch_name}" -b "${branch_name}"
  fi
}

# git worktree 削除(どのディレクトリにいても worktree 名で指定可能)
function git_worktree_remove() {
  local worktree_name=$1

  if [ -z "$worktree_name" ]; then
    echo "Usage: git_worktree_remove <worktree-name>"
    echo "Options: git_worktree_remove -f <worktree-name>  (force delete branch)"
    /usr/bin/git worktree list
    return 1
  fi

  # -f オプションでブランチ強制削除
  local force_delete=false
  if [ "$worktree_name" = "-f" ]; then
    force_delete=true
    worktree_name=$2
    if [ -z "$worktree_name" ]; then
      echo "Usage: git_worktree_remove -f <worktree-name>"
      return 1
    fi
  fi

  # worktree listから該当するパスを探す
  local -a worktree_info
  worktree_info=("${(@f)$(/usr/bin/git worktree list | /usr/bin/grep "${worktree_name}[[:space:]]")}")

  if [ ${#worktree_info} -eq 0 ]; then
    echo "Worktree '${worktree_name}' not found"
    /usr/bin/git worktree list
    return 1
  fi

  # 最初のフィールド（パス）を取得
  local path="${worktree_info[1]%% *}"

  # 3番目のフィールド（ブランチ名）を取得して [] を削除
  local branch="${worktree_info[1]}"
  branch="${branch##*\[}"
  branch="${branch%%\]*}"

  # worktreeを削除
  echo "Removing worktree: ${path}"
  /usr/bin/git worktree remove "$path"

  if [ $? -ne 0 ]; then
    echo "Failed to remove worktree"
    return 1
  fi

  # ブランチが取得できた場合のみブランチ削除を試みる
  if [ -n "$branch" ]; then
    if [ "$force_delete" = true ]; then
      # 強制削除
      echo "Force deleting branch: ${branch}"
      /usr/bin/git branch -D "$branch"
    else
      # マージ済みかチェック
      if /usr/bin/git branch --merged | /usr/bin/grep -q "^[* ]*${branch}\$"; then
        echo "Branch '${branch}' is merged. Deleting..."
        /usr/bin/git branch -d "$branch"
      else
        echo "⚠️  Branch '${branch}' is NOT merged yet."
        echo "To keep the branch: Do nothing"
        echo "To delete anyway: wtr -f ${worktree_name}"
        return 0
      fi
    fi
  fi
}

#-----------------------------------------------------------
# retry until failure (useful for detecting flaky tests)
function retry_until_fail() {
  local count=0

  if [ $# -eq 0 ]; then
    echo "Usage: retry_until_fail <command> [args...]"
    echo "Example: retry_until_fail bin/rspec spec/some_spec.rb:123"
    return 1
  fi

  while true; do
    count=$((count + 1))
    echo "[retry_until_fail] Attempt $count"
    "$@"
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
      echo "Command failed with exit code $exit_code after $count attempts"
      return 0
    fi

    echo "[retry_until_fail] Command succeeded, running again..."
  done
}

