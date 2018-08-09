class Admin::BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)

  def index
    @books = Book.order_by.search(params[:search])
                 .page(params[:page])
                 .per Settings.per_page
  end

  def new
    @book = Book.new
    @book.author_books.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit :name,:description, :image,
      :publish_date, :price, :category_id, author_books_attributes:
      [:id, :book_id, :author_id]
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to admin_books_path
  end
end
