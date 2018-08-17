class AuthorsController < ApplicationController
  before_action :find_author, except: %i(index new create)
  before_action :find_author_book, only: :show

  def index
    @authors = Author.list_author
                     .search(params[:search])
                     .page(params[:page])
                     .per Settings.per_page
  end

  def show
    @list_books = Book.author_book_by(@author)
                      .page(params[:page])
                      .per Settings.per_page
  end

  private

  def find_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t ".danger"
    redirect_to authors_path
  end

  def find_author_book
    @book = Book.find_by id: params[:author_id]
  end
end
