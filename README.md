Quester は、匿名で質問を集めて回答してもらうシンプルなサービスです。  
デプロイ先（参考）：https://quester-6xv7.onrender.com

## 概要
- X アカウントでログインして質問を投稿（回答は匿名で送信）
- みんなの質問一覧 / 自分の質問一覧（回答受付中・締め切り）
- 質問共有リンク（X シェア）
- 文字数カウンター付きの投稿/回答フォーム

## 技術スタック
- Ruby 3.2 / Rails 7.1
- MySQL / ActiveStorage (S3)
- Devise + Omniauth (X/Twitter)
- Kaminari, MiniMagick, Sprockets
- CI: GitHub Actions（テスト・依存更新ワークフローあり）

## 使い方
1. X でログイン  
2. 質問する（最大1000文字）  
3. みんな/自分の質問を見て回答する（匿名送信）

## ローカルセットアップ
```bash
bundle install
yarn install --check-files
rails db:create db:schema:load
rails s
```
環境変数（X APIキーなど）は `config/credentials.yml.enc` または Render の環境変数で設定してください。

## テスト
```bash
bundle exec rspec
```

## デプロイ
- Render で稼働中。Ruby 3.2、MySQL、ImageMagick が必要です。
- 依存アップデート用の Actions ワークフロー（Dependency Patch / Rails Upgrade）を用意しています。

## ライセンス
記載がなければオーナーの方針に従ってください。***
