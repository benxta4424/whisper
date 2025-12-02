class PostsController < ApplicationController
  def new
    @post=current_user.posts.build
  end

  # In app/controllers/posts_controller.rb
  def index
    flwr_ids = current_user.follower_relationships.pluck(:followed_id)
    flwr_ids << current_user.id
    
    # Good: You're using includes
    @posts = Post.where(user_id: flwr_ids)
                .includes(:user, :likes, comments: :user)
                .order(created_at: :desc) # Use order instead of .ascending scope
    
    # This chat_room query is inefficient:
    @chat_room = ChatRoom.where("follower_id = ? OR followed_id = ?", current_user.id, current_user.id)
    chat_room_ids = @chat_room.pluck(:id)
    
    # Optimize the message query:
    last_message_ids = Message.where(chat_room_id: chat_room_ids)
                              .select('DISTINCT ON (chat_room_id) id, chat_room_id, content, user_id')
                              .order('chat_room_id, created_at DESC')
                              .map(&:id)
                              
    @last_messages = {}
    latest_messages = Message.where(id: last_message_ids).includes(:user, :chat_room)
    
    latest_messages.each do |message|
      chat_room = message.chat_room
      other_user_id = (chat_room.follower_id == current_user.id) ? chat_room.followed_id : chat_room.follower_id
      @last_messages[other_user_id] = message.content
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
