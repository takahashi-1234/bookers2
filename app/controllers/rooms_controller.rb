class RoomsController < ApplicationController
  def create
    @room=Room.create
    @join_current_user=Entry.create(user_id: current_user.id,room_id: @room.id)
    @join_user=Entry.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room=Room.find(params[:id])
    if Entry.where(user_id: current_user.id ,room_id: @room.id).present?
      @messages=@room.messages
      @message=Message.new
      @users=@room.users
      @user=@users.where.not(id: current_user.id)
    else
      redirect_back(fallback_locaton: root_path)
    end
  end

  private
  def join_room_params
    params.require(:entry).permit(:user_id,:room_id).merge(room_id: @room.id)
  end
end
