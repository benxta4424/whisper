class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[ show edit update destroy ]

  # GET /chat_rooms or /chat_rooms.json
  def index
    @chat_rooms = ChatRoom.all
  end
  def new
    @user=User.find_by(id: params[:followed_id])
    @chat_room = ChatRoom.find_by(id: params[:chat_room_id])
  end

  # GET /chat_rooms/1/edit
  def edit
  end

  # POST /chat_rooms or /chat_rooms.json
  def create
    @user=User.find_by(id: params[:followed_id])

    @chat_room = ChatRoom.find_or_create_by(
      follower_id: current_user.id,
      followed_id: @user&.id
    ) || ChatRoom.find_or_create_by(
      follower_id: @user&.id,
      followed_id: current_user.id
    )

    redirect_to chat_room_path(@chat_room) if @chat_room.present?
  end

  # PATCH/PUT /chat_rooms/1 or /chat_rooms/1.json
  def update
    respond_to do |format|
      if @chat_room.update(chat_room_params)
        format.html { redirect_to @chat_room, notice: "Chat room was successfully updated." }
        format.json { render :show, status: :ok, location: @chat_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_rooms/1 or /chat_rooms/1.json
  def destroy
    @chat_room.destroy!

    respond_to do |format|
      format.html { redirect_to chat_rooms_path, status: :see_other, notice: "Chat room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show
    @chat_room=ChatRoom.find(params[:id])
    @user=User.find_by(id: @chat_room.followed_id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_room_params
      params.permit(:follower_id, :followed_id)
    end
end
