class Tag < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :articles, through: :article_tag_relation

  # 一意性の制限は、単体モデルで記述する。また、case_sensitive: falseは、大文字小文字の使い分けをしない設定で、DBのcollationなしでエラーを回避している。
  validates :name, uniqueness: { case_sensitive: false }
end
