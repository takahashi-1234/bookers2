class BooksController < ApplicationController

  def index
    @user=User.find(current_user.id)
    @books=Book.all
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create]="Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user=User.find(current_user.id)
      @books=Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_update]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def show
    @create_book=Book.find(params[:id])
    @book=Book.new
    @user=User.find(@create_book.user.id)
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
