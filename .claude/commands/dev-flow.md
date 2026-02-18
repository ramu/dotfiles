---
allowed-tools: Read, Edit, Write, Glob, Grep, Bash(git status *), Bash(git diff *), Bash(git add *), Bash(git commit *), Bash(git log *), Bash(git switch *), Bash(git rev-parse *), Bash(git merge-base *), Bash(git push *), Bash(git branch *), Bash(mkdir *), Bash(npm test *), Bash(pnpm test *), Bash(make test *), Bash(cargo test *), Bash(pytest *), Bash(go test *), Bash(gh issue view *), Bash(gh pr create *)
description: 要件分解から実装・レビューまでを一気通貫で実行する統合ワークフロー
---

# 統合開発ワークフローコマンド

要件の分解から振り返りまでを一気通貫で実行します。

```
Phase 1  [decompose]        要件からタスクリスト(.md)を生成
    |
Phase 2  (user)             タスクリストを確認・編集
    |
Phase 3  [ralph-loop]       タスクごとに実装・テスト・コミット
    |
Phase 4  [review-self]      コミットのバグ・セキュリティをチェック
    |
    +---> 重大な問題あり? --yes--> [ralph-loop] 修正 (最大2回)
    |                                    |
    |     (問題なし or スキップ)            +---> [review-self] 再チェック
    |<-----------------------------------+
    |
Phase 5  [commit / pr]      コミット維持、またはブランチ+PR作成
    |
Phase 6  [retrospective]    進捗ログを分析し学びを抽出
    |
Phase 7  [summary]          完了レポートを表示
```

## 引数の解析

`$ARGUMENT` をスペース区切りで解析:

| 引数 | 必須 | 説明 | デフォルト |
|------|------|------|-----------|
| 第1引数 | ✅ | 要件ソース（ファイルパス、`#Issue番号`、自然言語テキスト） | - |
| 第2引数 | - | 完了アクション: `commit` または `pr` | `commit` |
| 第3引数 | - | 最大イテレーション数 | 10 |

### 要件ソースの判定
- `#` で始まる → GitHub Issue 番号（`#42` → Issue #42）
- ファイルパスとして存在する → 要件ファイル
- それ以外 → 自然言語テキスト

### 使用例

```
/dev-flow requirements.md
/dev-flow requirements.md pr
/dev-flow #42 pr 20
/dev-flow "ユーザー認証機能をJWTベースで実装"
/dev-flow "ログイン画面にバリデーション追加" commit 5
```

## 実行フロー

### Phase 1: 要件分解

`~/.claude/commands/decompose.md` の手順を読み込み、その内容に従って実行する（Issue 番号・ファイルパス・自然言語テキストの判定は decompose.md 側で行われる）。

**Phase 1 の出力**: タスクリストファイルのパス（以降のフェーズで使用）

### Phase 2: タスクリスト確認

生成されたタスクリストをユーザーに提示し、確認を求める:

```
═══ タスクリスト確認 ═══

{タスクリストの内容を表示}

このタスクリストで実装を開始します。
```

AskUserQuestion を使って以下の選択肢を提示する:
- **このまま実行**: タスクリストを変更せずに Phase 3 へ進む
- **編集してから実行**: ユーザーがタスクリストを手動編集する時間を設け、編集完了後に Phase 3 へ進む

### Phase 3: 自動実装（Ralph Loop）

1. **開始コミットハッシュを記録**: `git rev-parse HEAD` で Phase 3 開始時点のコミットハッシュを控える（Phase 4 で `{開始ハッシュ}..HEAD` をコミット範囲として使用する）
2. **完了アクションが `pr` の場合**: `git branch --show-current` で現在のブランチ名を取得し、`main` または `master` であれば `git switch -c {ブランチ名}` でフィーチャーブランチを作成してから実行する（ブランチ名は要件から適切に命名。例: `feat/user-auth`, `fix/login-validation`）。既にフィーチャーブランチ上にいる場合はそのまま使用する
3. `~/.claude/commands/ralph-loop.md` の手順を読み込み、その内容に従って実行する

- タスクリストファイル: Phase 1 で生成したファイル
- 最大イテレーション数: 引数で指定された値

### Phase 4: セルフレビュー

`~/.claude/commands/review-self.md` の手順を読み込み、その内容に従って実行する。

- コミット範囲: Phase 3 で記録した開始ハッシュを使い `{開始ハッシュ}..HEAD` を渡す

#### 修正が必要な場合

review-self が「致命的」または「重要」な問題を検出した場合:

1. 生成された修正タスクリストを表示
2. AskUserQuestion で確認:
   - **修正を実行**: 修正タスクリストで ralph-loop を再実行し、完了後に再度 review-self を実行（最大 2 回まで）
   - **修正をスキップ**: 問題を無視して Phase 5 へ進む
3. 修正ループ後も問題が残る場合は、残存問題を表示して Phase 5 へ進む

### Phase 5: 完了アクション

引数の完了アクションに応じて実行する。

#### `commit` の場合（デフォルト）

Phase 3 の ralph-loop 内で既にコミット済みのため、追加のコミット作業は不要。
完了サマリーを表示して終了。

#### `pr` の場合

Phase 3 でフィーチャーブランチ作成・コミットは完了しているため、リモートへの push と PR 作成のみを行う。

`~/.claude/commands/create-pr.md` の手順を読み込み、その内容に従って PR を作成する。

### Phase 6: 振り返り

`~/.claude/commands/retrospective.md` の手順を読み込み、その内容に従って実行する。

- 進捗ログファイル: Phase 3 の ralph-loop が生成した `.progress.md`

### Phase 7: 完了報告

以下のサマリーを表示する:

```
═══ 開発フロー完了 ═══

## 要件
{要件の要約}

## 実装結果
- 完了タスク: {N}/{M}
- コミット数: {N}
- 変更ファイル数: {N}

## レビュー結果
- 致命的: {N} / 重要: {N} / 軽微: {N}
{修正した場合: - 修正済み: {N} 件}

## 成果物
{commit の場合}
- ブランチ: {ブランチ名}
- コミットログ: {直近のコミット一覧}

{pr の場合}
- Pull Request: {PR URL}
```

## ルール

- **各 Phase の独立性**: 各フェーズは対応するコマンドファイルの手順をそのまま実行する。dev-flow 独自のロジックで上書きしない
- **ユーザー確認ポイントを省略しない**: Phase 2 のタスクリスト確認と Phase 4 の修正確認は必ずユーザーに提示する
- **エラー時の継続判断**: Phase 3 で ralph-loop がエラー終了した場合は、完了済みタスクのサマリーを表示し、Phase 4 以降に進むか AskUserQuestion で確認する
