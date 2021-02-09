class Article < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  belongs_to :user
  has_one_attached :image
  has_many :article_tag_relations, dependent: :destroy
  has_many :tags, through: :article_tag_relations
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def liked_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.create_article_ranking
    Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))
  end
end
