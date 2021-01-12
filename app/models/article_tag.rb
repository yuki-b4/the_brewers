class ArticleTag

  include ActiveModel::Model
  attr_accessor :title, :detail, :how_brew, :why_brew, :commit, :taste, :image, :name, :user_id

  with_options presence: true do
    validates :title
    validates :detail
    validates :how_brew
    validates :why_brew
    validates :taste
  end

  def save
    article = Article.create(title: title, detail: detail, how_brew: how_brew, why_brew: why_brew, commit: commit, taste: taste, image: image, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end

end