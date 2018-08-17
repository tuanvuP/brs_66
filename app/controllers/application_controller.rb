class ApplicationController < ActionController::Base
  before_action :load_user, only: :correct_user
  before_action :configure_permitted_parameters, if: :devise_controller?

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
  end

  def logged_in_user
    return if user_signed_in?
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

  def list_categories
    @categories = Category.all.select(:id, :title)
      .map{|category| [category.title, category.id]}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :avatar]
  end
end
