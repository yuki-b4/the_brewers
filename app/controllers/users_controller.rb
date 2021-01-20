class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, only: [:show]

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles
  end

  def bookmark_list
    @favorite_articles = current_user.favorite_articles.order('favorites.created_at desc')
  end

  private
  def move_to_index
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to root_path
    end
  end
end
