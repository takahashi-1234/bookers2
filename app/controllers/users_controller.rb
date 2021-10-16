class UsersController < ApplicationController
  def edit
    @user=User.find(params[:id])
      if @user == current_user
        render :edit
      else
        redirect_to user_path(current_user.id)
      end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:user_update]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @book=Book.new
    @user=User.find(current_user.id)
    @users=User.all
  end

  def show
    @book=Book.new
    @user=User.find(params[:id])
    @current_user_entry=Entry.where(user_id: current_user.id)
    @user_entry=Entry.where(user_id: @user.id)
    unless @user.id==current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id==u.room_id
            @is_room=true
            @room_id=cu.room_id
          end
        end
      end
      if @is_room
      else
        @room=Room.new
        @entry=Entry.new
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:profile_image,:name,:introduction)
  end

end
