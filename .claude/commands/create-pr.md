---
allowed-tools: Bash(gh pr create:*), Bash(git push:*), Bash(git log:*), Bash(git diff:*), Bash(git rev-parse:*), Bash(git branch:*)
description: Pull Request を作成する
---

# Pull Request 作成コマンド

現在のブランチからドラフト Pull Request を作成します。

## 前提条件
- GitHub CLI (`gh`) が設定済みで認証済みであること
- リポジトリへのプッシュ権限があること
- コミット済みの変更があること

## 動作
1. ベースブランチを特定する
2. ブランチをリモートにプッシュする
3. 適切なサマリーとテスト計画を含む Pull Request を作成する

## ベースブランチの特定
以下の優先順位でベースブランチを決定する:
1. ユーザーから指定された場合はそれを使用する
2. 現在のブランチの分岐元を検出する
3. リポジトリのデフォルトブランチ（main または master）を使用する

## Pull Request の詳細
PR は以下の内容で作成されます:
- **ステータス**: ドラフト（レビューと調整のためにレディにする前に確認可能）
- **タイトル**: 変更内容の説明的なサマリー（日本語）
- **ベースブランチ**: 検出された親ブランチ
- **説明**（日本語）: 以下を含む:
  - 変更のサマリー
  - ER 図やシーケンス図を Mermaid で表現（コードレビューの理解に役立つ場合）
  - コミット一覧
  - テスト計画または検証手順
  - 関連する Issue（検出された場合）

注: Pull Request のタイトルと説明はチームコミュニケーションを円滑にするために日本語で記述されます。

### Mermaid ダイアグラムのガイドライン
コードレビューの理解に役立つ場合、以下のような図を含める:

**ER 図**: データベーススキーマの変更がある場合
```mermaid
erDiagram
    User ||--o{ Order : places
    User {
        int id PK
        string email
        string role "新規追加"
        datetime created_at
        datetime updated_at
    }
    Order {
        int id PK
        int user_id FK
        decimal total_amount
        datetime created_at
        datetime updated_at
    }
```

**シーケンス図**: API フローや処理の流れを説明する場合
```mermaid
sequenceDiagram
    participant C as Client
    participant A as AuthController
    participant S as AuthService
    participant DB as Database

    C->>A: POST /auth/login
    A->>S: authenticate(email, password)
    S->>DB: find_user_by_email
    DB-->>S: User record
    S->>S: verify_password
    S->>S: generate_jwt_token
    S-->>A: {token, user_info}
    A-->>C: 200 OK {token, user}
```

**状態遷移図**: ステータスの遷移ロジックがある場合
```mermaid
stateDiagram-v2
    [*] --> Draft: 書類作成
    Draft --> Submitted: 提出
    Submitted --> Approved: 承認
    Submitted --> Rejected: 却下
    Approved --> Processing: 処理開始
    Processing --> Completed: 完了
    Rejected --> Draft: 修正
    Completed --> [*]
```

**クラス図**: サービスアーキテクチャの変更がある場合
```mermaid
classDiagram
    class AuthService {
        +authenticate(email, password)
        +generateToken(user)
        +validateToken(token)
        -hashPassword(password)
    }

    class UserRepository {
        +findByEmail(email)
        +create(userData)
        +update(id, userData)
    }

    class JWTService {
        +encode(payload)
        +decode(token)
        +verify(token)
    }

    AuthService --> UserRepository : uses
    AuthService --> JWTService : uses
```

## 出力
- Pull Request URL
