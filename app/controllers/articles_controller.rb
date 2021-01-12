class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:user).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :detail, :how_brew, :why_brew, :commit, :taste, :image).merge(user_id: current_user.id)
  end
end
