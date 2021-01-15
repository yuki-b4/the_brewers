class ArticleTag

  include ActiveModel::Model
  attr_accessor :title, :detail, :how_brew, :why_brew, :commit, :taste, :image, :name, :user_id

  with_options presence: true do
    validates :title
    validates :detail
    validates :how_brew
    validates :why_brew
    validates :taste
    validates :name
    validates :user_id
  end

  delegate :persisted?, to: :article

  def initialize(attributes = nil, article: Article.new)
    @article = article
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?
    
    ActiveRecord::Base.transaction do
      tags = split_tag_names.map { |name| Tag.find_or_create_by!(name: name) }
      article.update(title: title, detail: detail, how_brew: how_brew, why_brew: why_brew, commit: commit, taste: taste,
                                 image: image, tags: tags, user_id: user_id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
    # article = Article.create(title: title, detail: detail, how_brew: how_brew, why_brew: why_brew, commit: commit, taste: taste,
    #                          image: image, user_id: user_id)
    # tag = Tag.where(name: name).first_or_initialize
    # tag.save

  def to_model
    article
  end

  private

  attr_reader :article

  def default_attributes
    {
      title: article.title,
      detail: article.detail,
      how_brew: article.how_brew,
      why_brew: article.why_brew,
      commit: article.commit,
      taste: article.taste,
      image: article.image,
      name: article.tags.pluck(:name).join(",")
    }
  end

  def split_tag_names
    name.split(",")
  end

end

