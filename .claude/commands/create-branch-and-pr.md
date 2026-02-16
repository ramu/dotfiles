---
allowed-tools: Bash(gh pr create:*), Bash(git status:*), Bash(git diff:*), Bash(git checkout:*), Bash(git add:*), Bash(git commit:*), Bash(git push:*), Bash(git rev-parse:*), Bash(git branch:*), Bash(git log:*)
description: 新しいブランチと Pull Request を作成する
---

# ブランチ作成と Pull Request 提出コマンド

フィーチャーブランチの作成、コミットの整理、Pull Request の提出を自動化します。

## 前提条件
- リポジトリにコミットする予定の変更がある（ステージ済みまたは未ステージ）
- GitHub CLI (`gh`) が設定済みで認証済みであること
- リポジトリへのプッシュ権限があること
- 意図しない未追跡ファイルがないこと（意図的な変更のみが存在する状態）

## 動作

以下のサブコマンドの手順を **順番に** 実行してください。
各ステップで対応するコマンドファイルを読み込み、その手順に従ってください。

### ステップ 1: ブランチ作成

`~/.claude/commands/create-branch.md` を読み込み、手順に従って実行する。

**重要**: このステップで記録された **親ブランチ名** を、ステップ 3 の PR 作成時にベースブランチとして使用するので覚えておくこと。

### ステップ 2: スマートコミット

`~/.claude/commands/smart-commit.md` を読み込み、手順に従って実行する。

### ステップ 3: Pull Request 作成

`~/.claude/commands/create-pr.md` を読み込み、手順に従って実行する。

**重要**: ベースブランチには、ステップ 1 で記録した **親ブランチ** を使用すること。

## 出力
- ブランチ名
- ベースブランチ名
- コミットメッセージ
- Pull Request URL
