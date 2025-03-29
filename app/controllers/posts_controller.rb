class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  def index
    find_user=User.find_by(name: params[:search_user_field])

    flwr_ids=current_user.follower_relationships.pluck(:followed_id)
    flwr_ids<<current_user.id
    @posts=Post.where(user_id: flwr_ids).ascending

    if params[:search_user_field].present?
      user=User.find_by(name: params[:search_user_field])
      redirect_to user_path(user) if user
    end

    # find the last messages of each convo between the current user and his/her friends
    @chat_room=ChatRoom.where("follower_id = ? OR followed_id = ?", current_user.id, current_user.id)
    @last_messages={}

    unless @chat_room.nil?
      @chat_room.each do |room_id|
        find_player=Message.where(chat_room_id: room_id).last.user_id
        find_message=Message.where(chat_room_id: room_id).last.content
        @last_messages[find_player]=find_message
      end
    end
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
