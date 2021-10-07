class BooksController < ApplicationController

  def index
    @user=User.find(current_user.id)
    @books=Book.all
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:create]="Book was successfully created."
      redirect_to book_path(current_user.id)
    else
      @user=User.find(current_user.id)
      @books=Book.all
      render :index
    end
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_update]="You have updated book successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @book=Book.find(params[:id])
    @user=User.find(@book.user.id)
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title,:body)
    end
end
