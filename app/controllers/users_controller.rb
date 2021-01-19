class UsersController < ApplicationController
  before_action :authenticate_user!

  def bookmark_list
    @favorite_articles = current_user.favorite_articles.order("favorites.created_at desc")
  end
end
