class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  def index
    @posts=Post.all
  end

  def create
    @post=current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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
