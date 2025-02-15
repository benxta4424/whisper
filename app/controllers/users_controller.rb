class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @followers=@user.followers
    @followed=@user.following
    @posts = @user.posts.order(created_at: :desc)
  end
end
