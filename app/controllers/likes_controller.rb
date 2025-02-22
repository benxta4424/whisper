class LikesController < ApplicationController
  def create
    @like=Like.create(like_params)
    respond_to do |format|
      if @like.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])

    if @like
      @like&.destroy
      flash[:succesfully_unlike]="Succesfully unliked post!"
    else
      flash[:failed_unlike]="Failed to unlike post!"
    end
  end

  def like_params
    params.permit(:user_id, :post_id)
  end
end
