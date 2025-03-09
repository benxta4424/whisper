class FriendshipsController < ApplicationController
  def create
    @friendship=Friendship.create(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user=User.find_by(id: params[:followed_id])
    find_friendship=Friendship.find_by(follower_id: current_user.id, followed_id: user&.id)

    if find_friendship
      find_friendship.destroy
    else
      flash[:friendship_not_found]="Friendship not found!"
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:follower_id, :followed_id)
  end
end
