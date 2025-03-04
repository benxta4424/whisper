class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  def index
    flwr_ids=current_user.follower_relationships.pluck(:followed_id)
    flwr_ids<<current_user.id
    @posts=Post.where(user_id: flwr_ids).ascending
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
    params.expect(post: [ :title ])
  end
end
