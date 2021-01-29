# アプリ名 
TheBrewers

# 概要
The Brewersは、コーヒーを愛する人たちに向けて作られた、コーヒーレシピ共有アプリケーションです。  
記事の投稿、編集、検索などの必要不可欠な機能に加え、記事のお気に入り登録や、タグ付けなどの機能も備えています。

# 開発環境
ruby: 2.6.5
Rails: 6.0.3.4

# 本番環境について

### URL
http://54.95.42.87/

### テスト用アカウント
- email: ppp@example.com
- password: bartley4sy
 
# 制作背景

## 開発の意図
このアプリケーションは、  

① コーヒーをもっと楽しみたい人の  
**「料理のレシピをまとめたサイトがある一方で、コーヒーのレシピをまとめたサイトがないから、美味しい淹れ方がわからないし、どういう風にアレンジすればいいかわからない」**

② 自分のスキルや考えを共有したい人の  
**「自分が美味しいと思うコーヒーの淹れ方を共有したいが、そのようなプラットフォームが存在しない」**

という、異なる層のユーザーが抱えていた不満や課題を解決するために作成されたアプリケーションです。

### 具体的には、このような課題を解決しようとしました。
- 「自分は普段こうやってコーヒーを淹れている。この方法を共有したい！けど、クックパッドのようなレシピサイトではあまり見られないだろうし、youtubeなどのメディアを利用するほどでもない。」  
- 「どうやったら、コーヒーは美味しく淹れられるんだろうと思い、いろいろなサイトや本を探す。良さそうなレシピを見つけて『今度やろう！』と思っても、メモするのを忘れて、結局どこのやつだったっけ...となってしまう。」  
- 「珈琲屋で買ったコーヒー、せっかくだったら美味しく淹れたい。でも、豆の種類やお店ごとの単位で淹れ方についてまとめているサイトはないからいちいち各社のHPなどを参照しないといけない。」

# 実際の様子
- 投稿の際、記事をいったん保存したい場合は、下書きとして保存することができます。下書きに保存した記事は、ヘッダーの下書きフォルダから一覧で確認することができます。  
下書きとして保存した投稿が、下書き一覧から閲覧できる様子: https://gyazo.com/4e9238916338b1911c41aaf041c177be

- 編集ページでは、一度公開していた記事でも、もう一度下書きに戻すこともできます。  
下書きを公開に変更すると、記事の一覧表示画面にその記事が表示されている様子: https://gyazo.com/925d735508a5350f68aac7f3278450d5

- 投稿された記事には、実際に試してみた感想を伝えるためのレビュー欄が存在します。ログインすると、レビューを投稿することができます。  
ログインしたユーザーがレビューを投稿する様子: https://gyazo.com/332f642977fd8cd20864784fb04112c1

- 真似してみたいなと思った記事は、マネしたいボタンを押すと、ヘッダーにある自分のマネしたいフォルダに保存され、保存した記事を一覧で確認することができます。（ログインユーザーのみ）  
マネしたいボタンを押し、マネしたいリストに反映されている様子: https://gyazo.com/66656033192dc583f336f115485a391c

# 工夫したポイント
- 機能を厳選し、必要最小限に抑えることで、シンプルだが実用的なアプリケーションを目指した。
- 自分の求める情報にアクセスしやすいように、お気に入り機能を実装することで、自分の気になる記事を保存できるようにした。
- お気に入りされた側が、投稿への意欲を失わず継続的な利用が促されるように、投稿に対する累計のお気に入り数を表示するようにした。
- 投稿者が自分のペースで投稿ができるように、下書き機能を実装した。
- 投稿にタグを紐づけ、その検索を可能としたことで、twitterやinstagramのように自分調べたい情報を見つけやすいようにした。
- ユーザー間でコミュニケーションをとることができるように、レシピのレビュー機能を設けた。
- ユーザーの環境やステータスが変わっても利用しやすいように、登録したユーザー情報の編集機能を設けた。
- 将来的にビジネスユースも可能になるように、ログイン機能の実装と、ユーザー詳細情報への工夫を凝らした。

# 実装予定の機能と課題
## 実装予定の機能	
- フォーム入力時のウィザード形式の導入
- サイト内での検索ワード、閲覧数ランキングを掲載
- パンくずリストの導入

## 課題
- ページをみただけで何のページなのかが判別できるページレイアウトの差別化
- 一度投稿した画像が、編集・更新すると消えてしまう

# ローカルでの動作方法	
```ターミナル
git clone https://github.com/yuki-b4/the_brewers.git
cd the_brewers (アプリのディレクトリに移動)
bundle install
yarn add jquery
rails db:migrate
```

# テーブル設計

## Usersテーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| job_id             | integer | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| drink_coffee_id    | integer |                           |
| favorite_shop      | string  |                           |

- has_many favorites
- has_many :favorite_articles, through: :favorites, source: :article
- has_many reviews
- has_many articles

## Articlesテーブル
| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| title    | string     | null: false       |
| detail   | string     | null: false       |
| how_brew | text       | null: false       |
| why_brew | text       | null: false       |
| commit   | string     |                   |
| taste    | string     | null: false       |
| user_id  | references | foreign_key: true |
| status   | integer    | null: false       |

- has_many favorites
- has_many reviews
- has_many article_tag_relations
- has_many tags, through article_tag_relations
- belongs_to user

## Favoritesテーブル
| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| article_id | references | foreign_key: true |
| user_id    | references | foreign_key: true |

- belongs_to user
- belongs_to article

## Reviewsテーブル
| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| review     | string     | null: false       |
| article_id | references | foreign_key: true |
| user_id    | references | foreign_key: true |

- belongs_to user
- belongs_to article

## Tagsテーブル
| Column | Type   | Options                       |
| ------ | ------ | ----------------------------- |
| name   | string | null: false, uniqueness: true |

- has_many article_tag_relations 
- has_many articles, through article_tag_relations

## Article_tag_relationsテーブル
| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| tag_id     | references | foreign_key: true |
| article_id | references | foreign_key: true |

- belongs_to tag
- belongs_to article