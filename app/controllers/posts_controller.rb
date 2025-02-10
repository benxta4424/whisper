class PostsController < ApplicationController
  def new
    @post=Post.new
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
      render "pages/index", status: :unprocessable_entity    end
  end

  def show
    @post=Post.find(params[:id])
  end

  private
  def post_params
    params.require(:posts).permit(:title)
  end
end
