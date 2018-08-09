class BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)
  before_action :load_mark_book, only: :show

  def index
    @books = Book.filter(params.slice :search_name, :category_id)
                 .page(params[:page])
                 .per Settings.book.per_page
    @categories = Category.all
  end

  def show
    @comments = @book.comments.all
    @comment = @book.comments.build
  end

  private

  def book_params
    params.require(:book).permit :name, :description, :image,
      :publish_date, :price, :category_id
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to books_path
  end

  def load_mark_book
    if current_user.present?
      @mark_book = MarkBook.find_by(user_id: current_user.id, book_id: @book.id) || MarkBook.new
    end
  end
end
