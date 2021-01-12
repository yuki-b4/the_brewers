class Article < ApplicationRecord
   belongs_to :user
   has_one_attached :image
   has_many :article_tag_relations
   has_many :tags, through: :article_tag_relations
end
