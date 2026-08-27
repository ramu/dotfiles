#!/bin/zsh
# herdr プロジェクトランチャ
#
#   hd            プロジェクトを fzf で選んで起動
#   hd <name>     projects/<name>.sh を実行 (同名のワークスペースがあればフォーカスのみ)
#   hd -l         プロジェクト一覧
#   hd -e <name>  プロジェクト定義を $EDITOR で開く (無ければ雛形から作成)

export HERDR_DIR="${HERDR_DIR:-$HOME/.config/herdr}"

_hd_projects() {
  local f
  for f in "$HERDR_DIR"/projects/*.sh(N); do
    print -r -- "${${f:t}%.sh}"
  done
}

hd() {
  local projects_dir="$HERDR_DIR/projects"

  case ${1:-} in
    -h|--help)
      print -r -- 'usage: hd [-l|--list] [-e|--edit <name>] [<name>]'
      return 0 ;;
    -l|--list)
      _hd_projects
      return 0 ;;
    -e|--edit)
      local n=${2:-}
      if [[ -z $n ]]; then
        print -u2 -r -- 'hd: プロジェクト名が必要です'
        return 1
      fi
      mkdir -p "$projects_dir"
      [[ -f $projects_dir/$n.sh ]] || cp "$HERDR_DIR/project.sh.example" "$projects_dir/$n.sh"
      ${EDITOR:-vi} "$projects_dir/$n.sh"
      return $? ;;
  esac

  if ! herdr status server >/dev/null 2>&1; then
    print -u2 -r -- 'hd: herdr サーバが起動していません。先に herdr を起動してください'
    return 1
  fi

  local name=${1:-}
  if [[ -z $name ]]; then
    if (( $+commands[fzf] )); then
      name=$(_hd_projects | fzf +m --prompt='herdr project> ') || return 1
    else
      _hd_projects
      return 0
    fi
  fi
  [[ -n $name ]] || return 1

  # 同名のワークスペースが既にあれば、作り直さずフォーカスするだけ
  local ws
  ws=$(herdr workspace list 2>/dev/null \
        | jq -r --arg n "$name" '.result.workspaces[] | select(.label == $n) | .workspace_id' \
        | head -1)
  if [[ -n $ws ]]; then
    herdr workspace focus "$ws" >/dev/null
    return 0
  fi

  local script="$projects_dir/$name.sh"
  if [[ ! -f $script ]]; then
    print -u2 -r -- "hd: プロジェクト定義が見つかりません: $script"
    print -u2 -r -- "hd: 'hd -e $name' で雛形から作成できます"
    return 1
  fi

  HD_NAME=$name sh "$script"
}

if (( $+functions[compdef] )); then
  _hd() { _arguments '1:project:($(_hd_projects))' }
  compdef _hd hd
fi
