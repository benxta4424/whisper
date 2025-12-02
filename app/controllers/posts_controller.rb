class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  def index
    find_user=User.find_by(name: params[:search_user_field])

    flwr_ids=current_user.follower_relationships.pluck(:followed_id)
    flwr_ids<<current_user.id
    @posts = Post.where(user_id: flwr_ids)
                 .includes(:user, :likes, comments: :user) # Load Post -> User, Post -> Likes, and Post -> Comments -> User
                 .ascending

    if params[:search_user_field].present?
      user=User.find_by(name: params[:search_user_field])
      redirect_to user_path(user) if user
    end

    # find the last messages of each convo between the current user and his/her friends
    @chat_room=ChatRoom.where("follower_id = ? OR followed_id = ?", current_user.id, current_user.id)
    chat_room_ids = @chat_room.pluck(:id)
    # Select the maximum (most recent) ID for each chat_room_id group
    last_message_ids = Message.where(chat_room_id: chat_room_ids)
                              .group(:chat_room_id)
                              .maximum(:id)
                              .values

    # Load the actual Message records in one query, includes users
    latest_messages = Message.where(id: last_message_ids).includes(:user) 

    # Rebuild your @last_messages hash efficiently
    @last_messages = {}
    @chat_room.each do |chat_room|
      # Find the corresponding message from the pre-loaded collection
      message = latest_messages.find { |m| m.chat_room_id == chat_room.id } 

      if message
        # Determine the other user in the chat
        other_user_id = (chat_room.follower_id == current_user.id) ? chat_room.followed_id : chat_room.follower_id
        @last_messages[other_user_id] = message.content
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
