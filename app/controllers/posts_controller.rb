class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def index
    @posts=Post.all
  end

  def create
    @user = User.find(current_user.id)
    @post=current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Post Created!" }
      end
    else
      render "pages/index"
    end
  end

  def show
    @post=Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title).merge(user_id: current_user.id)
  end
end
