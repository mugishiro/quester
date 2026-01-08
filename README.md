Quester is a simple service for collecting anonymous questions and receiving answers.
Demo (reference): https://quester-6xv7.onrender.com

## Usage
1. Sign up / Log in  
   Use your X account to sign up or log in.
2. Ask a question  
   Ask anything you're curious about.
3. Answer  
   Answers are anonymous, so feel free to reply casually.

## Local setup
```bash
bundle install
yarn install --check-files
rails db:create db:schema:load
rails s
```

## Tests
```bash
bundle exec rspec
```

---

Quester は、匿名で質問を集めて回答してもらうシンプルなサービスです。  
デプロイ先（参考）：https://quester-6xv7.onrender.com

## 使い方
1. 登録/ログインする  
   Xアカウントを使って登録/ログインしましょう。
2. 質問する  
   疑問に思うことがあれば、何でも質問してみましょう。
3. 回答する  
   回答は匿名なので、気楽に送ってみましょう。

## ローカルセットアップ
```bash
bundle install
yarn install --check-files
rails db:create db:schema:load
rails s
```

## テスト
```bash
bundle exec rspec
```
