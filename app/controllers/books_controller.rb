class BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)
  before_action :load_mark_book, only: :show
  before_action :list_categories, only: :index
  before_action :load_user, only: :following_book

  def index
    @book_as_max_like = Book.like_max
                            .page(params[:page]).per Settings.book.per_page
    @book_as_max_reading = Book.reading_max(:reading)
                               .page(params[:page]).per Settings.book.per_page
    @search_books = Book.ransack params[:q]
    @books = @search_books.result.includes(:category).order_by
                          .page(params[:page]).per Settings.book.per_page
  end

  def show
    @comments = @book.comments.all
    @comment = @book.comments.build
  end

  def following_book
    @title = t ".title"
    @books = Book.following_book(@user)
                     .page(params[:page])
                     .per Settings.per_page
    render :show_book_follow
  end

  def follower_books
    @title = t ".title"
    @users = @book.follower_books
                  .page(params[:page])
                  .per Settings.per_page
    render :show_follow_book
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
