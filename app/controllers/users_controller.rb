class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @followers=@user.followers
    @followed=@user.following
  end
end
