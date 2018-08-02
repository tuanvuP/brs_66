class BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)

  def index
    @books = Book.list_book.page(params[:page])
                 .per Settings.per_page
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
end
