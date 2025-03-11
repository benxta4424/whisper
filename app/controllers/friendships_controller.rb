class FriendshipsController < ApplicationController
  def create
    @user=User.find_by(id: params[:user_id])
    @friendship=Friendship.create(follower_id: current_user.id, followed_id: @user&.id)

    respond_to do |format|
      if @friendship.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user=User.find_by(id: params[:user_id])
    find_friendship=Friendship.find(params[:id])
    find_friendship.destroy! if find_friendship.present?

    respond_to do |format|
        format.turbo_tream
        format.html { redirect_to user_path(@user), status: :unprocessable_entity }
    end
  end
end
