#!/bin/bash
# deny-check.sh の回帰テスト
#
# 実行: ~/.claude/scripts/deny-check.test.sh
#
# 検査対象の settings.json は実際の設定ではなく、このスクリプト内の
# フィクスチャを使う。deny リストを編集してもテストが壊れないようにするため。

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$SCRIPT_DIR/deny-check.sh"

if [ ! -f "$TARGET" ]; then
  echo "deny-check.sh が見つかりません: $TARGET" >&2
  exit 1
fi

TEST_HOME=$(mktemp -d "${TMPDIR:-/tmp}/deny-check-test.XXXXXX") || exit 1
trap 'rm -rf "$TEST_HOME"' EXIT

mkdir -p "$TEST_HOME/.claude" "$TEST_HOME/tmp"
cat >"$TEST_HOME/.claude/settings.json" <<'JSON'
{
  "permissions": {
    "deny": [
      "Bash(chmod 777:*)",
      "Bash(curl:*)",
      "Bash(git config:*)",
      "Bash(rm:*)",
      "Bash(sudo:*)",
      "Edit(.env)"
    ]
  }
}
JSON

PASSED=0
FAILED=0

# run_case <deny|allow> <コマンド> [備考]
run_case() {
  local expect="$1"
  local cmd="$2"
  local note="${3:-}"

  local payload
  payload=$(jq -n --arg cmd "$cmd" '{tool_name: "Bash", tool_input: {command: $cmd}}')

  local status
  printf '%s' "$payload" | HOME="$TEST_HOME" bash "$TARGET" >/dev/null 2>&1
  status=$?

  local actual
  case "$status" in
    0) actual="allow" ;;
    2) actual="deny" ;;
    *) actual="error($status)" ;;
  esac

  local label="${cmd//$'\n'/\\n}"
  [ -n "$note" ] && label="$label  # $note"

  if [ "$actual" = "$expect" ]; then
    PASSED=$((PASSED + 1))
    printf '  ok   [%-5s] %s\n' "$actual" "$label"
  else
    FAILED=$((FAILED + 1))
    printf '  FAIL [%-5s] expected=%s  %s\n' "$actual" "$expect" "$label"
  fi
}

echo "== 拒否されるべきコマンド =="
run_case deny 'rm -rf /tmp/x'
run_case deny ' rm /tmp/x' '前後の空白'
run_case deny 'chmod 777 /tmp/x'
run_case deny 'chmod  777 /tmp/x' '空白の表記揺れ'
run_case deny 'git config user.name foo' '複数語のパターン'
run_case deny 'sudo ls'

echo
echo "== ラッパー・パス指定の除去 =="
run_case deny '/bin/rm -f /tmp/x' '絶対パス'
run_case deny './rm /tmp/x' '相対パス'
run_case deny 'command rm /tmp/x'
run_case deny 'builtin rm /tmp/x'
run_case deny 'exec rm /tmp/x'
run_case deny 'nohup rm /tmp/x'
run_case deny 'env rm /tmp/x'
run_case deny 'env FOO=bar rm /tmp/x' '環境変数付き'
run_case deny 'FOO=bar rm /tmp/x' '先頭の環境変数代入'
run_case deny 'FOO=bar command /bin/rm /tmp/x' 'ラッパーの多重適用'

echo
echo "== 複合コマンドの分割 =="
run_case deny 'git status && rm /tmp/x' '&&'
run_case deny 'git status || rm /tmp/x' '||'
run_case deny 'git status; rm /tmp/x' ';'
run_case deny 'echo hi | sudo tee /etc/hosts' 'パイプ'
run_case deny 'sleep 1 & rm /tmp/x' 'バックグラウンド実行'
run_case deny 'ls /tmp
rm /tmp/x' '改行区切り'

echo
echo "== 許可されるべきコマンド =="
run_case allow 'git status'
run_case allow 'npm run build'
run_case allow 'grep -rn foo /tmp'
run_case allow 'chmod 755 /tmp/x' '別の権限値'
run_case allow 'chmod 7777 /tmp/x' '前方一致の境界'
run_case allow 'git configure-something' '前方一致の境界'
run_case allow 'rmdir /tmp/x' 'rm で始まる別コマンド'
run_case allow 'echo rm' '引数に現れるだけ'
run_case allow 'ls -la | head -20' '許可コマンド同士のパイプ'

echo
echo "== 既知の限界（静的検査では追えないため素通りする） =="
run_case allow 'bash -c "rm -rf /tmp/x"' 'シェル経由の間接実行'
run_case allow 'echo $(rm -rf /tmp/x)' 'コマンド置換'
run_case allow 'eval "$CMD"' '実行時に決まる文字列'

echo
echo "== 既知の誤検知（取りこぼしを減らす代償として許容する） =="
# 誤検知が起きるのは、引数の中に区切り文字と拒否語が並んだときに限られる。
run_case deny 'echo "a | sudo b"' '引数の中の区切り文字と拒否語'
run_case allow 'git commit -m "rm を trash に置き換える"' '区切り文字がなければ誤検知しない'

echo
echo "passed=$PASSED failed=$FAILED"
[ "$FAILED" -eq 0 ]
