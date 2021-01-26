class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles
  end

  def bookmark_list
    @favorite_articles = current_user.favorite_articles.order('favorites.created_at desc')
  end
end
