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
| Column   | type       | Options           |
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