# にゃんまっち。- 保護猫マッチングアプリ

## 1. サービス概要
里親を探す人と猫を結ぶ、直感的で簡単な保護猫マッチングサービスです。

## 2. サービスの画像

- ホーム画面  
![ホーム画面](https://github.com/nyaxa0306/NyanMatch/blob/main/app/assets/images/home.png) 

- 猫詳細画面
![猫詳細画面](https://github.com/nyaxa0306/NyanMatch/blob/main/app/assets/images/cat_show.png)   

## 3. サービスのURL  
[https://nyan-match-e22ca14a51cd.herokuapp.com/](https://nyan-match-e22ca14a51cd.herokuapp.com/)

## 4. 開発背景
身近な知人が「猫を保護したのに引き取り手が見つからない」と苦労している姿を見たこと、  
そして自分自身も既に複数の猫を飼っており、もし今後保護することがあれば同じように困るかもしれないと感じたことがきっかけでした。

保護主と里親希望者をつなぐ仕組みは存在するものの、情報管理や連絡方法がバラバラで負担が大きいという課題があります。  
そこで、猫の登録から応募までをシンプルに行えるサービスを目指して「にゃんまっち。」を開発しました。

## 5. 機能

### ユーザー関連
- ユーザー登録・ログイン（Devise 使用）
- 保護主（猫を登録できるユーザー）と里親希望者で権限を区別

### 猫の登録・管理
- 猫の新規登録・編集・削除（保護主のみ）
- 画像アップロード（ActiveStorage）
- Home に新着猫を 6 件表示

### 検索・閲覧
- 猫のキーワード検索（名前 / 性格 / 地域など）
- 絞り込み検索（複数条件）

### マッチング・リアクション
- 猫の詳細ページで「お気に入り」登録
- 応募機能（里親申請）

### マイページ関連
- 自分が登録した猫一覧
- お気に入り一覧
- 応募申請の一覧

## 6. 主な使用技術

### フロントエンド
- HTML / ERB / CSS / JavaScript
- Bootstrap 5, Stimulus, Turbo

### バックエンド
- Ruby 3.3.3, Rails 7.2.3
- PostgreSQL
- Devise（認証）, ActiveStorage（画像管理）
- RSpec / Capybara（テスト）

## インフラ・開発環境
- Puma（Webサーバ）
- Ubuntu / WSL2 / Heroku（デプロイ）

## 7. ER図  
![ER図](https://github.com/nyaxa0306/NyanMatch/blob/main/app/assets/images/ER%E5%9B%B31.png)
![ER図](https://github.com/nyaxa0306/NyanMatch/blob/main/app/assets/images/ER%E5%9B%B32.png)

## 8. 今後の展望  
- 画像アップロードをS3で管理 
- モバイル最適化、PWA対応  
