# Issue 作業手順

Issue #$ARGUMENT の内容を確認し、以下の作業ルールに従って対応してください。

## ワークフロー

- [ ] Issue に作業開始のコメントを投稿する
- [ ] `gh issue view` コマンドで Issue #$ARGUMENT の詳細情報を取得する
- [ ] 取得した詳細に基づいて Issue #$ARGUMENT の要件と受け入れ基準を分析する
- [ ] Issue #$ARGUMENT 用のフィーチャーブランチを作成する
- [ ] 要求された変更を実装する
- [ ] 必要に応じてテストを作成する
- [ ] テストを実行し、すべて通過することを確認する
- [ ] 説明に `closes #$ARGUMENT` を含めた Pull Request を作成する
- [ ] Issue に作業内容と Pull Request の URL をコメントする

## ルール

- すべてのコミットメッセージに Issue 番号を含める
- プロジェクトのコーディング規約に従う
- Pull Request を提出する前にすべての変更がテスト済みであることを確認する
- Pull Request は Issue の要件に焦点を当てた内容にする

## テンプレート

### 作業開始コメント

この issue の作業を開始します。

### 作業完了コメント

この issue の作業が完了しました。

対応内容:
- [主な変更点を記載]

Pull Request: [PR URL]
