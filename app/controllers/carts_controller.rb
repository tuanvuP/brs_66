class CartsController < ApplicationController
  before_action :load_cart, :load_book, only: %i(add_cart remove_book update_quantity)
  before_action :load_book_in_cart, only: :index

  def index; end

  def add_cart
    key_book = @book.id.to_s
    return redirect_to carts_path if session[:cart].key? key_book
    session[:cart][key_book] = Settings.cart.quantity
    redirect_to carts_path
  end

  def update_quantity
    session[:cart][params[:key]] = params[:quantity].to_i
    @book_in_cart = Book.by_book_ids session[:cart].keys
    respond_to do |format|
      format.js
    end
  end

  def destroy
    session.delete :cart if session[:cart]
    redirect_to root_path
  end

  def remove_book
    session[:cart].delete @book.id.to_s if session[:cart].key? @book.id.to_s
    redirect_to carts_path
  end
end
