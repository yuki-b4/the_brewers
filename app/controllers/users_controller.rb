class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def bookmark_list
    @favorite_articles = current_user.favorite_articles
  end
  
end
