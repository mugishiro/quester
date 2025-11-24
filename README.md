Quester は、匿名で質問を集めて回答してもらうシンプルなサービスです。
デプロイ先（参考）：https://quester-6xv7.onrender.com

## 使い方
1.登録/ログインする
Xアカウントを使って登録/ログインしましょう。
2.質問する
疑問に思うことがあれば、何でも質問してみましょう。
3.回答する
回答は匿名なので、気楽に送ってみましょう。

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