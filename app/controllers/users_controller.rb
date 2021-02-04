class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.published.order(created_at: :desc)
  end

  def bookmark_list
    @favorite_articles = current_user.favorite_articles.order('favorites.created_at desc')
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :job_id, :drink_coffee_id, :favorite_shop)
  end
end
