class BooksController < ApplicationController
  impressionist :actions => [:show]

  def index
    @user=User.find(current_user.id)
    @books=Book.includes(:favorites).sort{
      |a,b| b.favorites.where(created_at: Time.current.all_week).size <=> a.favorites.where(created_at: Time.current.all_week).size
    }
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
    @created_book=Book.find(params[:id])
    @book=Book.new
    @mypage=User.find(current_user.id)
    @user=User.find(@created_book.user.id)
    @new_comment=BookComment.new
    @comments=@created_book.book_comments
    impressionist(@created_book, nil, unique: [:impressionable_id, :ip_address])
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
