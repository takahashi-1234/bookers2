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
  end

  private
  def user_params
    params.require(:user).permit(:profile_image,:name,:introduction)
  end

end
