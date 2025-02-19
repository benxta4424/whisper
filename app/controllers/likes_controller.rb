class LikesController < ApplicationController
  def new
    @like=Like.new
  end

  def create
    @like=Like.new(like_params)
  end

  private

  def like_params
    params.permit(:likes).require(:user_id, :post_id)
  end
end
