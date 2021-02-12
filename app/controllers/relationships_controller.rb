class RelationshipsController < ApplicationController

  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = "ユーザーをフォローしました"
    else
      flash.now[:alert] = "ユーザーをフォローできませんでした。"
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = "フォローを解除しました"
    else
      flash[:alert] = "フォローの解除に失敗しました"
    end
  end



  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
