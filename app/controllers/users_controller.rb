class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :move_to_index]
  before_action :move_to_index, only: [:show]

  def show
    @user_articles = @user.articles
  end

  def bookmark_list
    @favorite_articles = current_user.favorite_articles.order('favorites.created_at desc')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @user.id
  end
end
