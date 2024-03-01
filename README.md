## ■サービス概要
自作の謎を投稿したり、AIを使用して謎を生成したり自由に謎の投稿・閲覧・解答するためのサービスです。
謎の正解数に応じてポイントが付与され、ポイント数によってバッチの取得・ランキング表示などを予定しており
回答者としても出題者としても楽しめるサービスです。
*** 
僕は謎解きや脱出ゲームが好きでよくやっているのですが、
本格的な謎解きや・ミステリー小説などは時間がかかってしまうので、気軽に短時間でミステリーや謎解きを体験したい。
また、自分も謎解きの問題を作成できたら良いなと考えていました。
しかし、玄人やプロが作った謎の投稿サービスはあるのですが、謎作成の初心者が気軽に投稿できる様な投稿サービスはあまりなかったので作成してみようと思いました。
*** 
## ■ ユーザー層について
謎解きに触れた事がない方でも気軽に謎解き体験ができる。自作の謎を作成してみたいが、作り方もわからない人がAIを通して簡単に作成できる様にしたいと思っています。
- 謎解きに触れてみたい方
- 謎解きに興味がある方
- 謎を作成してみたい方
*** 

## ■サービスの利用イメージ
- 投稿された謎の一覧表示
- 自分で作成した謎を投稿できる(画像 or 文章)
- 問題作成時に
  + 謎のタイトル・カテゴリ・答えを入力し、タイプを選択(テキスト形式 or 画像形式)し、投稿できる様にする。
  + テキスト形式の場合は、フォームに自由に記入でき生成AIを使用して短編小説を生成できる
  + 画像形式の場合は、答えに入力したモノの名前や言葉(ことわざなど)を抽象化した画像を生成し投稿。
- AI使用は必須ではなく、テキスト投稿・画像投稿の両形式とも自由に投稿できるようにしようと思っています。
- 投稿詳細ページから回答ができ、正解した時にポイントが付与される。
  
- 人気のある謎(いいね数などで管理)をランキング形式で表示するので、自分で作成した謎が受け入れられているのかの
フィードバックを数値で得られるようにします。

*** 

## ■ ユーザーの獲得について
- Xを用いた宣伝
- 友人やスクール内のコミュニティでの宣伝

*** 

## ■ サービスの差別化ポイント・推しポイント
玄人が自作で作ったイラスト形式の謎を投稿・回答できるサービスはあるが、初心者向けに謎が回答・投稿できるサービスにしたいので
下記の機能を差別化ポイントとしています。
- 初心者が簡単に問題を投稿できる様に、生成AIを使用して短文の推理問題が投稿できる
- 文章の読み上げAPIを使用して文章の推理問題を読み上げて世界観を作る
- 日常にあるモノや言葉(ことわざなど)を抽象化した画像を生成し、答えが何かを推理する

### 例 (下記はことわざの「仏の顔も三度まで」を画像生成しました)
  
[![Image from Gyazo](https://i.gyazo.com/5a8f257211bcb2c676cfbe178dd8ffce.png)](https://gyazo.com/5a8f257211bcb2c676cfbe178dd8ffce)

*** 

## ■ 機能候補
現状作ろうと思っている機能、案段階の機能をしっかりと固まっていなくても構わないのでMVPリリース時に作っていたいもの、本リリースまでに作っていたいものをそれぞれ分けて教えてください。
### MVPリリース
- ユーザー登録
    - メール・パスワード
- ログイン
- パスワードリセット機能
- プロフィール編集機能
    - ニックネーム・アドレス変更
- 問題を新規投稿
    - OpenAIを使用した画像生成で謎画像を投稿
- カテゴリ機能
- 検索機能
- 正解時にポイント付与
- ポイント数に応じてユーザーランキング表示
- X(Twitter)シェア機能

### MVP以降
- OpenAIを使用した推理問題の生成と投稿
- text-to-speech APIを使用した文章の読み上げ機能
- ポイント数に応じて称号を付与
- いいね数で人気の謎をランキング表示
- いいね機能
- Google認証

*** 

## ■ 機能の実装方針予定
- OpenAI API (文章生成・画像生成)
- Google text-to-speech API(文章読み上げ)
- Google認証

*** 

## 画面遷移図
Figma_URL：https://www.figma.com/file/5RuNkrEx6rOlGueZG4lVHj/EnigmaCraft_%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&mode=design&t=vht4UijhSbsprpTd-1

### READMEに記載した機能
- [ ] ユーザー登録機能
- [ ] ログイン機能
- [ ] パスワード変更機能
- [ ] メールアドレス変更機能
- [ ] ニックネーム・アバター変更機能
- [ ] 謎投稿機能（画像投稿含む）
- [ ] 謎閲覧機能（未ログインでも閲覧可能）
- [ ] 謎への回答機能（未ログインでも回答可能）
- [ ] AI 謎画像生成機能
- [ ] AI 謎生成機能
- [ ] 謎編集機能
- [ ] 謎削除機能
- [ ] 正解時にポイント付与
- [ ] タイトル・カテゴリ 検索機能
- [ ] カテゴリ投稿機能
- [ ] いいね一覧
- [ ] いいね機能
- [ ] いいね解除機能

### 未ログインでも閲覧または利用できるページ
以下の項目は適切に未ログインでも閲覧または利用できる画面遷移になっているか？
- [ ] 謎への回答機能（未ログインでも回答可能）
- [ ] 謎閲覧機能（未ログインでも閲覧可能）
- [ ] 謎一覧機能（未ログインでも閲覧可能）

### メールアドレス・パスワード変更確認項目
直接変更できるものではなく、一旦メールなどを介して専用のページで変更する画面遷移になっているか？
- [ ] パスワード

*** 

## ■ER図
[![Image from Gyazo](https://i.gyazo.com/7ea34121feef9bf603390475f51a6380.png)](https://gyazo.com/7ea34121feef9bf603390475f51a6380)

### テーブル情報

- users **( ユーザー登録 )**
  + name :ニックネーム
  + email :メールアドレス
  + crypted_password パスワード (sorceryを使用予定です)
  + point :ポイント
    - 謎問題の正解時にポイントを付与するので、ポイント管理のため
  + role :権限

- Mysteries **( 謎解きの問題を登録 )**
  + title :問題のタイトル
  + type :問題のタイプ
    - 謎問題をテキスト形式か画像形式の問題かをタイプで管理
  + content :謎の問題を保存 (小説タイプ or 画像タイプ)
  + correct_answer :問題の答え
  + user_id 
  + genre_id

- bookmarks **( ユーザーがいいねをした問題を管理 )**
  + user_id
  + mystery_id
 
 - answers **( ユーザーが正解済みの問題を管理 )**
  + user_id
  + mystery_id
  + correct_flag 正解・不正解を管理
 
- genre **( 問題のジャンルを管理 タグのイメージで複数のカテゴリで管理)**
  + name ジャンル名

- mysery_genres
  + mystery_id
  + genre_id

### 詳細情報
今回、自分で作成した謎(画像 or 文章)を投稿できるようにしたい為、
Mysteriesテーブルのcontentカラムに、作成した謎のテキストを保存をする形を想定しています。
- contentカラムに**NotNull**を設定し、**「テキストか画像のどちらかが存在することを条件」**でカスタムバリデーションを作成。

- 画像や音声データに関しては、ActiveStrageを使用してAWSのS3での保存し、モデルにhas_one_attachedで関連付ける。

上記2点での運用を考えています。
