class Admin::BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)
  before_action :list_categories, :list_authors, only: %i(new edit)

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

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit :name,:description, :image,
      :publish_date, :price, :category_id, author_ids:[], author_books_attributes:
      [:id, :book_id, :author_id]
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to admin_books_path
  end

  def list_categories
    @categories = Category.all.select(:id, :title).map{|category| [category.title, category.id]}
  end

  def list_authors
    @authors = Author.all.select(:id, :name).map{|author| [author.name, author.id]}
  end
end
