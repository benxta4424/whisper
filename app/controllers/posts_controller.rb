class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  def index
    @posts=Post.all
  end

  def create
    @post=current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Post Created!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post=Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title)
  end
end
