class LikesController < ApplicationController
  def create
    @like=Like.create(like_params)
    respond_to do |format|
      if @like.save
        format.html { flash[:succesfully_liked]="You've liked this post" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def like_params
    params.permit(:user_id, :post_id)
  end
end
