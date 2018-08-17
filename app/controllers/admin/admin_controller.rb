class Admin::AdminController < ApplicationController
  before_action :verify_admin

  def verify_admin
    return if user_signed_in? && current_user.admin?
    flash[:danger] = t ".danger"
    redirect_to root_path
  end
end
