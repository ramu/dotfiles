---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*)
description: 変更を分析し、論理的なコミットに自動分割する
---

# スマートコミットコマンド

変更を分析し、適切な場合は論理的なコミットに自動分割します。

## 前提条件
- コミットする変更がある（ステージ済みまたは未ステージ）

## 動作
1. 変更の全体像を把握する（以下のコマンドをそれぞれ個別に実行する。`&&` でのチェインは禁止）:
   - `git status --short` で変更ファイル一覧を確認
   - `git diff --stat` で変更の統計を確認
   - 必要に応じて `git diff <ファイル>` で詳細を確認
2. 論理的な単位にグループ化する
3. 各グループごとに説明的なコミットメッセージを作成してコミットする

## 自動コミット分割のガイドライン
- 機能、コンポーネント、または関心事ごとにコミットを分割する
- 関連するファイル変更は同じコミットにまとめる
- リファクタリングと機能追加は分離する
- 各コミットが独立して理解できるようにする
- 関連性のない複数の変更は別々のコミットに分割する

## コミットメッセージ形式
Conventional Commits 仕様に従います:
```text
<type>(<scope>): <subject>

<body>

<footer>
```

タイプ:
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント変更
- `refactor`: コードリファクタリング
- `test`: テストの追加または変更
- `chore`: メンテナンスタスク

## 使用例

### 例 1: 単一機能の追加
```bash
$ git status
modified:   app/controllers/auth_controller.rb
new file:   app/services/auth_service.rb
modified:   spec/controllers/auth_controller_spec.rb

# → 1 コミット: "feat: add authentication service with JWT support"
```

### 例 2: 複数の論理的な変更
```bash
$ git status
modified:   frontend/src/components/Header.tsx
modified:   frontend/src/utils/validators.ts
modified:   api/app/models/user.rb
new file:   api/db/migrate/add_role_to_users.rb

# → 3 コミット:
#   - "refactor: simplify Header component structure"
#   - "fix: correct email validation regex"
#   - "feat: add role-based access control to User model"
```

## 出力
- 作成されたコミットの一覧（メッセージ付き）
