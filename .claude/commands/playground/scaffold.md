# Usage: claude-code scaffold <requirements-file>

# コマンドライン引数チェック
if [ $# -ne 1 ]; then
  echo "Usage: claude-code scaffold <requirements-file>"
  echo "Example: claude-code scaffold requirements.md"
  exit 1
fi

REQUIREMENTS_FILE="$1"

# ファイル存在チェック
if [ ! -f "$REQUIREMENTS_FILE" ]; then
  echo "Error: File '$REQUIREMENTS_FILE' not found"
  exit 1
fi

# 出力ディレクトリの作成
OUTPUT_DIR="scaffold_output"
if [ -d "$OUTPUT_DIR" ]; then
  echo "Warning: Directory '$OUTPUT_DIR' already exists. Contents may be overwritten."
  read -p "Continue? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
else
  mkdir -p "$OUTPUT_DIR"
  echo "Created output directory: $OUTPUT_DIR"
fi

# Claude Code実行用のプロンプトテンプレート
cat << EOF | claude-code

# 🏗️ Project Scaffold Generation

あなたは経験豊富なシニアソフトウェアアーキテクトです。以下の要件定義書に基づいて、プロダクション品質のアプリケーションを生成してください。

## 📋 要件定義書
\`\`\`
$(cat "$REQUIREMENTS_FILE")
\`\`\`

## 🎯 実行手順

### 1. 📊 要件分析 (詳細)
- 要件定義書を詳細に分析
- 機能要件の優先度付け
- 技術的制約の特定
- パフォーマンス要件の考慮
- セキュリティ要件の確認
- 必要なファイル構成を決定

### 2. 📐 プロジェクトプランニング
- 適切な設計パターンの選択
- コンポーネント間の責任分離
- 拡張性を考慮した構造
- テスタビリティの確保
- ディレクトリ構造の設計
- 主要コンポーネントの洗い出し
- データモデル・API設計の策定

### 3. 🚀 初期実装の作成
- scaffold_output ディレクトリ内にプロジェクト構造を作成
- 実装品質を意識すること
  - **Clean Code**: 読みやすく保守しやすいコード
  - **SOLID原則**: 適切な設計原則の適用
  - **DRY原則**: 重複コードの排除
  - **Error Handling**: 包括的なエラー処理
  - **Performance**: 最適化されたコード
  - **Security**: セキュリティベストプラクティス
- 基本的なファイル・モジュールの実装
- 設定ファイルの作成
- README.mdとドキュメントの生成
- 基本的なテストの作成

## 🎨 出力形式
1. **分析結果**: 要件の理解と技術判断
2. **プロジェクト構造**: ディレクトリ・ファイル一覧
3. **実装**: 実際のコードファイルの生成
4. **次のステップ**: 継続開発のための推奨事項

## 🔧 制約事項
- 実際に動作するコードを生成する
- ベストプラクティスに従った実装
- 適切なコメントとドキュメントを含める
- セキュリティとパフォーマンスを考慮
- **重要**: 全てのファイルは scaffold_output ディレクトリ内に作成してください

実装を開始してください！

EOF
