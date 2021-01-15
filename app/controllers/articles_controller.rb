class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_article, only: [:edit, :update, :show]
  before_action :move_to_index, only: [:edit]

  def index
    @articles = Article.order(created_at: :desc).includes(:user)
  end

  def new
    @form = ArticleTag.new
  end

  def create
    @form = ArticleTag.new(article_params)
    if @form.valid?
      @form.save
      redirect_to root_path, notice: '投稿が完了しました！'   
    else
      render :new
    end
  end

  def edit
    @form = ArticleTag.new(article: @article)
  end

  def update
    @form = ArticleTag.new(article_params, article: @article)
    if @form.valid?
      @form.save
      redirect_to article_path(@article), notice: '投稿の更新が完了しました！'
    else
      render :edit
    end
  end

  def show
  end

  private

  def article_params
    params.require(:article).permit(:title, :detail, :how_brew, :why_brew, :commit, :taste, :image,
                                        :name).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @article.user.id
      redirect_to root_path
    end
  end
end
