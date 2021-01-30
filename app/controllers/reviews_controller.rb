class ReviewsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    Review.create(review_params)
    redirect_to article_path(@article)
  end

  private

  def review_params
    params.require(:review).permit(:review).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
