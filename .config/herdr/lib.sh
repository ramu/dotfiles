#!/bin/sh
# herdr プロジェクト定義用のヘルパー。
# projects/<name>.sh の冒頭で読み込んで使う。
#
#   . "${HERDR_DIR:-$HOME/.config/herdr}/lib.sh"
#
# 提供する関数:
#   hd_workspace <label> [cwd]      ワークスペースを作る (以降の起点)
#   hd_tab       <label> [cwd]      現在のワークスペースにタブを追加
#   hd_rename_tab <label>           現在のタブに名前を付ける
#   hd_split     right|down [cwd]   現在のペインを分割し、新ペインを対象にする
#   hd_run       <command...>       現在のペインでコマンドを実行
#   hd_agent     <name> <kind> [-- <agent-args...>]
#                                   現在のペインで AI agent を起動
#   hd_rename_pane <label>          現在のペインに名前を付ける
#   hd_focus                        作ったワークスペースにフォーカスする
#
# 状態は HD_WS / HD_TAB / HD_PANE に入る。

set -eu

_hd_run_api() {
  if ! _hd_out=$("$@" 2>&1); then
    printf 'herdr: コマンドが失敗しました: %s\n%s\n' "$*" "$_hd_out" >&2
    exit 1
  fi
  printf '%s' "$_hd_out"
}

_hd_jq() {
  printf '%s' "$1" | jq -er "$2"
}

hd_workspace() {
  _hd_label=$1
  _hd_cwd=${2:-$PWD}
  _hd_json=$(_hd_run_api herdr workspace create --cwd "$_hd_cwd" --label "$_hd_label" --no-focus)
  HD_WS=$(_hd_jq "$_hd_json" '.result.workspace.workspace_id')
  HD_TAB=$(_hd_jq "$_hd_json" '.result.tab.tab_id')
  HD_PANE=$(_hd_jq "$_hd_json" '.result.root_pane.pane_id')
  # ワークスペース作成時のタブは "1" という名前になるので label を引き継ぐ
  hd_rename_tab "$_hd_label"
}

hd_rename_tab() {
  _hd_run_api herdr tab rename "$HD_TAB" "$1" >/dev/null
}

hd_tab() {
  _hd_label=$1
  _hd_cwd=${2:-$PWD}
  _hd_json=$(_hd_run_api herdr tab create --workspace "$HD_WS" --cwd "$_hd_cwd" --label "$_hd_label" --no-focus)
  HD_TAB=$(_hd_jq "$_hd_json" '.result.tab.tab_id')
  HD_PANE=$(_hd_jq "$_hd_json" '.result.root_pane.pane_id')
}

hd_split() {
  _hd_dir=$1
  _hd_cwd=${2:-}
  if [ -n "$_hd_cwd" ]; then
    _hd_json=$(_hd_run_api herdr pane split "$HD_PANE" --direction "$_hd_dir" --cwd "$_hd_cwd" --no-focus)
  else
    _hd_json=$(_hd_run_api herdr pane split "$HD_PANE" --direction "$_hd_dir" --no-focus)
  fi
  HD_PANE=$(_hd_jq "$_hd_json" '.result.pane.pane_id')
}

hd_run() {
  _hd_run_api herdr pane run "$HD_PANE" "$*" >/dev/null
}

hd_agent() {
  _hd_name=$1
  _hd_kind=$2
  shift 2
  if [ "$#" -gt 0 ]; then
    _hd_run_api herdr agent start "$_hd_name" --kind "$_hd_kind" --pane "$HD_PANE" "$@" >/dev/null
  else
    _hd_run_api herdr agent start "$_hd_name" --kind "$_hd_kind" --pane "$HD_PANE" >/dev/null
  fi
}

hd_rename_pane() {
  _hd_run_api herdr pane rename "$HD_PANE" "$1" >/dev/null
}

hd_focus() {
  _hd_run_api herdr workspace focus "$HD_WS" >/dev/null
}
