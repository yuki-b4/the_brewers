class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @articles = Article.order(created_at: :desc).includes(:user)
  end

  def new
    @article = ArticleTag.new
  end

  def create
    @article = ArticleTag.new(article_params)
    if @article.valid?
      @article.save
      return redirect_to root_path   #！！！詳細ページが完成し次第、投稿した記事に飛べるように変更！！！
    else
      render :new
    end
  end

  private
  def article_params
    params.require(:article_tag).permit(:title, :detail, :how_brew, :why_brew, :commit, :taste, :image, :name).merge(user_id: current_user.id)
  end
end
