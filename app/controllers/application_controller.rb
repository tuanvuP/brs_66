class ApplicationController < ActionController::Base
  before_action :load_user, only: :correct_user

  include SessionsHelper
  include CartsHelper
  include OrdersHelper

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".not_exit"
    redirect_to root_path
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book.present?
    flash[:danger] = t ".not_found_book"
    redirect_to rooth_path
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".not_login"
    redirect_to login_url
  end

  def load_cart
    @cart = current_cart
    flash[:danger] = t ".cart_not_found" if @cart.nil?
  end

   def current_cart
    @cart = session[:cart] ||= {}
  end
end
