class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :confirm]
  before_action :set_article, only: [:edit, :update, :destroy, :show]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :set_q, only: [:index, :search]

  def index
    @articles = Article.published.order(created_at: :desc).includes(:user)
  end

  def new
    @form = ArticleTag.new
  end

  def create
    @form = ArticleTag.new(article_params)
    if @form.valid?
      @form.save
      redirect_to @form, notice: '投稿が完了しました！'
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
      if @article.published?
        redirect_to article_path(@article), notice: '投稿の更新が完了しました！'
      else
        redirect_to root_path, notice: '記事を下書きに戻しました。'
      end
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, notice: '削除が完了しました。' if @article.destroy
  end

  def show
    @review = Review.new
    @reviews = @article.reviews.includes(:user).order(created_at: :desc)
  end

  def search
    @results = @q.result.order(created_at: :desc)
  end

  def confirm
    @articles = current_user.articles.draft.order(created_at: :desc).includes(:user)
  end

  private

  def article_params
    params.require(:article).permit(:title, :detail, :how_brew, :why_brew, :commit, :taste, :image,
                                    :name, :status).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && current_user.id == @article.user.id
  end

  def set_q
    @q = Article.published.ransack(params[:q])
  end
end
