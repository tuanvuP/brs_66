class FavoritesController < ApplicationController
  before_action :logged_in_user, expect: :index
  before_action :load_book, only: :create

  def create
    @book = Book.find_by id: params[:book_id]
    if current_user.favorite @book
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t ".danger"
      redirect_back fallback_location: root_path
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to @book
  end
end
