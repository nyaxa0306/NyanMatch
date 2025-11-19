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
┌─────────────┐      ┌─────────────┐      ┌──────────────┐
│    Users    │─────>│     Cats    │─────>│ Applications │
├─────────────┤      ├─────────────┤      ├──────────────┤
│ id          │      │ id          │      │ id           │
│ email       │      │ name        │      │ user_id      │
│ encrypted_pw│      │ age         │      │ cat_id       │
│ nickname    │      │ gender      │      │ message      │
│ introduction│      │ breed       │      │ status       │
│ role        │      │ personality │      │ created_at   │
│ created_at  │      │ helth       │      │ updated_at   │
│ updated_at  │      │ status      │      └──────────────┘
└─────────────┘      │ user_id     │
                     │ prefecture_id│
                     │ created_at  │
                     │ updated_at  │
                     └─────────────┘
                           │
                           │
                           ▼
                     ┌─────────────┐
                     │  Favorites  │
                     ├─────────────┤
                     │ id          │
                     │ user_id     │
                     │ cat_id      │
                     │ created_at  │
                     │ updated_at  │
                     └─────────────┘

┌───────────────────────┐      ┌───────────────────────┐
│ ActiveStorage Attachments│───>│ ActiveStorage Blobs   │
├───────────────────────┤      ├───────────────────────┤
│ id                    │      │ id                    │
│ name                  │      │ key                   │
│ record_type           │      │ filename              │
│ record_id             │      │ content_type          │
│ blob_id               │      │ metadata              │
│ created_at            │      │ service_name          │
└───────────────────────┘      │ byte_size             │
                               │ checksum              │
                               │ created_at            │
                               └───────────────────────┘


## 8. 今後の展望  
- 画像アップロードをS3で管理  
- マッチングの精度向上（おすすめ猫表示機能など）  
- モバイル最適化、PWA対応  
