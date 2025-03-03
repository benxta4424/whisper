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
    @followers=@user.followers
    @followed=@user.following
    @posts = @user.posts.order(created_at: :desc)
  end
end
