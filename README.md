# The Brewers

The Brewersは、コーヒーを愛する人たちに向けて作られた、コーヒーレシピ共有アプリケーションです。
記事の投稿、検索などの基本的な機能はもちろん、記事のお気に入り登録や、タグ付けなどの機能も備えています。
 
#### こんな人に向けて作りました
- 「自分は普段こうやってコーヒーを淹れている。これを共有したい！」  
→その思い、方法を共有しましょう。

- 「どうやったら、コーヒーは美味しく淹れられるんだろう？」  
→その悩み、ここで解決するかもしれません。

- 「珈琲屋で買ったコーヒー、せっかくだったら美味しく淹れたい」  
→検索してみましょう。思いがけない発見があるかもしれません。

## URL
https://the-brewers.herokuapp.com/


## テスト用アカウント
- email: product@example
- password: bartley4sy

## 利用方法	
#### 共有してみたいレシピを管理しましょう
1. ユーザーを作成しましょう。
2. ヘッダーにある、「投稿する」ボタンを押して、記事を投稿してみましょう。もし、記事をいったん保存したい場合は、下書きとして保存することができます。下書きに保存した記事は、ヘッダーの下書きフォルダから一覧で確認することができます。
https://gyazo.com/75a1be682f08565101906fe92e0115a6

3. 投稿が完了したら、自分の投稿がどのように表示されているか、確認してみましょう。改行や、インデントには対応しています。リンクを貼った場合は、リンク化され、リンク先へ遷移することが可能です。
4. 投稿した記事は、記事の詳細ページから編集・削除が可能です。
5. 編集ページでは、一度公開していた記事でも、もう一度下書きに戻すこともできます。

#### 見つけたいレシピを探してみましょう
1. 気になる記事を、タイトルもしくはタグで検索してみましょう。
2. 投稿された記事には、実際に試してみた感想を伝えるためのレビュー欄が存在します。ログインすると、レビューを投稿することができます。
https://gyazo.com/332f642977fd8cd20864784fb04112c1

3. 真似してみたいなぁと思った記事は、マネしたいボタンを押しましょう。ヘッダーにある自分のマネしたいフォルダに保存され、保存した記事を一覧で確認することができます。（ログインユーザーのみ）
https://gyazo.com/66656033192dc583f336f115485a391c

4. 記事の作成者の名前をクリックすると、その人のプロフィールと投稿した記事が一覧で表示されます。
5. 自分の投稿やプロフィールは、ヘッダーの右上にある、「ようこそ、〇〇さん」をクリックすると確認できるようになっています。

## 目指した課題解決	
このアプリケーションは  
① コーヒーをもっと楽しみたい人の  
**「料理のレシピをまとめたサイトがある一方で、コーヒーのレシピをまとめたサイトがないから、美味しい淹れ方がわからないし、どういう風にアレンジすればいいかわからない」**

② 自分のスキルや考えを共有したい人の  
**「自分が美味しいと思うコーヒーの淹れ方を共有したいが、そのようなプラットフォームが存在しない」**

という、異なる層のユーザーが抱えていた不満をまとめ、需要と供給をマッチさせるために作成されたアプリケーションです。

## 実装予定の機能	
- ユーザー編集機能の実装
- フォーム入力時のウィザード形式の導入
- サイト内での検索ワード、閲覧数ランキングを掲載
- パンくずリストの導入


## ローカルでの動作方法	
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