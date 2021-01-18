class FavoritesController < ApplicationController
before_action :authenticate_user!
before_action :set_article

  def create  
    favorite = current_user.favorites.build(article_id: params[:article_id])
    favorite.save
  end

  def destroy
    favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    favorite.destroy
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end


end
