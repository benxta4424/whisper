class UsersController < ApplicationController
  def index
    @users = User.order(:name)
    @users = @users.where("name like ?", "%#{params[:term]}%") if params[:term]

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render json: @users.map(&:name) }
    end
  end
  def show
    @user=User.find(params[:id])
    @posts=@user.posts
    @followers=@user.followers
    @followed=@user.following
  end
end
