#!/bin/bash
# Ralph Loop - 外部ループスクリプト
# claude -p を使い、イテレーションごとに新しいコンテキストで実行する
# 長いタスクリストやオーバーナイト実行に最適
#
# Usage: ralph-loop.sh <task-file> [max-iterations]
# Example:
#   ~/.claude/scripts/ralph-loop.sh roadmap.md
#   ~/.claude/scripts/ralph-loop.sh roadmap.md 30

set -euo pipefail

TASK_FILE="${1:?Usage: ralph-loop.sh <task-file> [max-iterations]}"
MAX_ITERATIONS="${2:-10}"

if [ ! -f "$TASK_FILE" ]; then
  echo "Error: タスクファイル '$TASK_FILE' が見つかりません"
  exit 1
fi

# プロジェクト名の特定
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")

# 進捗ログの保存先
PROGRESS_DIR="$HOME/tmp/ralph-loop/$PROJECT_NAME"
mkdir -p "$PROGRESS_DIR"
TASK_BASENAME=$(basename "$TASK_FILE")
PROGRESS_FILE="$PROGRESS_DIR/${TASK_BASENAME%.*}.progress.md"

# テンポラリファイルのクリーンアップ
PROMPT_TMPFILE=""
cleanup() {
  [ -n "$PROMPT_TMPFILE" ] && rm -f "$PROMPT_TMPFILE"
}
trap cleanup EXIT INT TERM

# タスクファイルの形式に応じて未完了タスクの有無をチェック
# 未知の形式では常に true（未完了あり）を返し、ループを継続させる
has_remaining_tasks() {
  local file="$1"
  case "$file" in
    *.json)
      grep -Eq '"passes"[[:space:]]*:[[:space:]]*false' "$file" 2>/dev/null
      ;;
    *.md|*.markdown)
      grep -Eq '^[[:space:]]*- \[ \]' "$file" 2>/dev/null
      ;;
    *)
      # 未知の形式: 最大イテレーション数で安全に停止させる
      return 0
      ;;
  esac
}

# ワーキングディレクトリの確認
if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
  echo "⚠️  未コミットの変更が検出されました:"
  git status --short
  echo ""
  read -p "未コミット変更があります。続行すると無関係な変更がコミットに混入する可能性があります。続行しますか？ (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "中断しました。先に変更をコミットまたはスタッシュしてください。"
    exit 1
  fi
fi

echo "🚀 Ralph Loop 開始"
echo "📋 タスクファイル: $TASK_FILE"
echo "📝 進捗ログ: $PROGRESS_FILE"
echo "🔄 最大イテレーション: $MAX_ITERATIONS"
echo ""

for i in $(seq 1 "$MAX_ITERATIONS"); do
  echo "═══ イテレーション $i/$MAX_ITERATIONS ═══"

  # 未完了タスクの確認
  if ! has_remaining_tasks "$TASK_FILE"; then
    echo ""
    echo "✅ 全タスク完了！"
    exit 0
  fi

  # プロンプトをテンポラリファイルに構築（大きなファイル対応）
  PROMPT_TMPFILE=$(mktemp)

  cat > "$PROMPT_TMPFILE" <<PROMPT_EOF
# Ralph Loop - イテレーション $i/$MAX_ITERATIONS

## タスクリスト (\`$TASK_FILE\`)

\`\`\`
$(cat "$TASK_FILE")
\`\`\`

## 過去の進捗ログ (\`$PROGRESS_FILE\`)

$(if [ -f "$PROGRESS_FILE" ]; then cat "$PROGRESS_FILE"; else echo "(まだ進捗はありません)"; fi)

## 指示

以下の手順を実行してください:

1. **テスト検出**: まず \`README.md\` や \`CLAUDE.md\` にテスト実行方法の記載がないか確認する。なければ設定ファイル（package.json, Makefile, Cargo.toml 等）から検出する
2. **タスク選択**: 未完了タスクを1つ選択（優先度順 or ファイル内順序）
3. **実装**: 選択したタスクを実装
4. **テスト**: 検出したテストコマンドを実行（存在する場合）。失敗時は修正を試み、3回失敗したらスキップ
5. **完了マーク**: \`$TASK_FILE\` を更新して完了タスクにマークを付ける。Markdown なら \`- [ ]\` → \`- [x]\`、JSON なら \`passes: true\`。その他の形式はファイル内の既存の完了マーク表記に従う
6. **コミット**: \`~/.claude/commands/smart-commit.md\` を読み込み、その手順に従って変更を分析し論理的なコミットに分割・実行する
7. **進捗ログ**: \`$PROGRESS_FILE\` に以下の形式で追記:
   \`\`\`markdown
   ## [日付] - イテレーション $i
   ### タスク: [名前]
   - 実装内容: [概要]
   - 変更ファイル: [一覧]
   - 学んだこと: [パターンや注意点]
   ---
   \`\`\`

## ルール

- **1イテレーション = 1タスク**: 1つだけ実装して終了
- **スキップ**: 実装不可の場合は進捗ログに理由を記録して完了マークは付けない
- **最小限の変更**: タスクの要件に必要な変更のみ行う
PROMPT_EOF

  echo "🤖 Claude 実行中..."
  claude -p < "$PROMPT_TMPFILE" || true
  rm -f "$PROMPT_TMPFILE"
  PROMPT_TMPFILE=""

  echo ""
  echo "⏳ イテレーション $i 完了"

  # 完了チェック
  if ! has_remaining_tasks "$TASK_FILE"; then
    echo ""
    echo "✅ 全タスク完了！"
    exit 0
  fi

  sleep 2
done

echo ""
echo "⚠️ 最大イテレーション数 ($MAX_ITERATIONS) に到達しました"
echo "📋 残りのタスクを確認: $TASK_FILE"
exit 1
