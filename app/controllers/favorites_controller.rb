class FavoritesController < ApplicationController
  def create
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.new(book_id: @book.id)
    favorite.save
    @books=Book.includes(:favorites).sort{|a,b| b.favorites.where(created_at: Time.current.all_week).size <=> a.favorites.where(created_at: Time.current.all_week).size}

    render :index
  end

  def destroy
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    @books=Book.includes(:favorites).sort{|a,b| b.favorites.where(created_at: Time.current.all_week).size <=> a.favorites.where(created_at: Time.current.all_week).size}
    render :index
  end
end
