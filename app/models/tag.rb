class Tag < ApplicationRecord
  has_many :article_tag_relations
  has_many :article, through: :article_tag_relation

  validates :name, uniqueness: true   #一意性の制限は、単体モデルで記述する。
end
