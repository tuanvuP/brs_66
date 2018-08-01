class ApplicationController < ActionController::Base
  before_action :load_user, only: :correct_user

  include SessionsHelper

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".not_exit"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".not_login"
    redirect_to login_url
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
