class MarkBooksController < ApplicationController
  before_action :logged_in_user, expect: :index
  before_action :load_mark_book, only: :update

  def new
    @mark_book = MarkBook.new
  end

  def create
    @mark_book = MarkBook.new mark_book_params
    respond_to do |format|
      if @mark_book.save
        format.html{redirect_to @mark_book.book}
        format.js
      else
        redirect_to book_path @mark_book.book_id
        format.html{redirect_to @mark_book.book}
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @mark_book.update_attributes mark_book_params
        format.html{redirect_to @mark_book.book}
        format.js
      else
        format.html{redirect_to @mark_book.book}
        format.js
      end
    end
  end

  private

  def mark_book_params
    params.require(:mark_book).permit :status, :user_id, :book_id
  end

  def load_mark_book
    @mark_book = MarkBook.find_by user_id: current_user.id,
      book_id: params[:mark_book][:book_id]
    return if @mark_book
    flash[:danger] = t ".danger"
    redirect_to @mark_book
  end
end
