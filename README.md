# にゃんまっち。  

## 1. サービス概要  
里親を探す人と猫を結ぶ、直感的で簡単なマッチングサービス。  

## 2. サービスの画像  
![ホーム画面](./images/home.png)  
![猫一覧画面](./images/cats_index.png)  
※画像は `./images/` 配下に保存  

## 3. サービスのURL  
[https://nyan-match.example.com](https://nyan-match.example.com)  ※実際のURLに置き換え  

## 4. 開発背景  
猫の里親探しは情報が散在しており、希望者が探しづらい現状があります。

そこで、簡単に猫を探せて、里親希望者とスムーズにマッチングできるサービスとして開発しました。  

## 5. 機能  
- 猫の登録・編集・削除  
- 猫の検索・絞り込み（名前・性格・地域など）  
- ユーザー登録・ログイン（Devise使用）  
- お気に入り機能  
- 応募機能（ActionCableでリアルタイム）  

## 6. 主な使用技術  

### フロントエンド
- HTML / ERB / CSS / JavaScript
- Bootstrap 5, Stimulus, Turbo

### バックエンド
- Ruby 3.3.3, Rails 7.2.3
- PostgreSQL
- Devise（認証）, ActiveStorage（画像管理）
- RSpec / Capybara（テスト）

### インフラ・開発環境
- Puma（Webサーバ）
- Ubuntu / WSL2 / Heroku（デプロイ）  

## 7. ER図  
erDiagram
    USERS ||--o{ CATS : "has many"
    USERS ||--o{ APPLICATIONS : "has many"
    USERS ||--o{ FAVORITES : "has many"

    CATS ||--o{ APPLICATIONS : "has many"
    CATS ||--o{ FAVORITES : "has many"

    ACTIVE_STORAGE_BLOBS ||--o{ ACTIVE_STORAGE_ATTACHMENTS : "has many"
    ACTIVE_STORAGE_BLOBS ||--o{ ACTIVE_STORAGE_VARIANT_RECORDS : "has many"

    APPLICATIONS }o--|| USERS : "belongs to"
    APPLICATIONS }o--|| CATS : "belongs to"

    FAVORITES }o--|| USERS : "belongs to"
    FAVORITES }o--|| CATS : "belongs to"

    CATS }o--|| USERS : "belongs to"

    ACTIVE_STORAGE_ATTACHMENTS }o--|| ACTIVE_STORAGE_BLOBS : "belongs to"
    ACTIVE_STORAGE_VARIANT_RECORDS }o--|| ACTIVE_STORAGE_BLOBS : "belongs to"

    USERS {
        bigint id PK
        string email
        string encrypted_password
        string nickname
        text introduction
        integer role
        datetime created_at
        datetime updated_at
    }

    CATS {
        bigint id PK
        string name
        integer age
        string gender
        string breed
        text personality
        text helth
        string status
        bigint user_id FK
        integer prefecture_id
        datetime created_at
        datetime updated_at
    }

    APPLICATIONS {
        bigint id PK
        bigint user_id FK
        bigint cat_id FK
        text message
        integer status
        datetime created_at
        datetime updated_at
    }

    FAVORITES {
        bigint id PK
        bigint user_id FK
        bigint cat_id FK
        datetime created_at
        datetime updated_at
    }

    ACTIVE_STORAGE_BLOBS {
        bigint id PK
        string key
        string filename
        string content_type
        text metadata
        string service_name
        bigint byte_size
        string checksum
        datetime created_at
    }

    ACTIVE_STORAGE_ATTACHMENTS {
        bigint id PK
        string name
        string record_type
        bigint record_id
        bigint blob_id FK
        datetime created_at
    }

    ACTIVE_STORAGE_VARIANT_RECORDS {
        bigint id PK
        bigint blob_id FK
        string variation_digest
    }


## 8. 今後の展望  
- 画像アップロードをS3で管理  
- マッチングの精度向上（おすすめ猫表示機能など）  
- モバイル最適化、PWA対応  
