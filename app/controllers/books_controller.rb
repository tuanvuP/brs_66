class BooksController < ApplicationController
  def index
    @books = Book.list_book.page(params[:page])
                 .per Settings.book.per_page
  end

  private

  def book_params
    params.require(:book).permit :name, :description, :image,
      :publish_date, :price, :category_id
  end
end
