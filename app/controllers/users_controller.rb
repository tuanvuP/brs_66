class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(edit update)

  def index
    @users = User.search(params[:search])
                 .page(params[:page])
                 .per Settings.per_page
  end

  def show
    @follow = current_user.active_follows.build
    @list_favorites = Book.favored_by @user
    @list_read = Book.read_by @user
  end

  def likes
    @books = current_user.liked.page(params[:page]).per Settings.per_page
  end

  def favorites
    @books = current_user.favorited
  end

  def following
    @title = t ".title"
    @users = @user.following.following_by(@following_by)
                  .page(params[:page]).per Settings.user.per_page
    render :show_follow
  end

  def followers
    @title = t ".title"
    @users = @user.followers.following_by(@following_by)
                  .page(params[:page]).per Settings.user.per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :username, :email, :password,
      :password_confirmation, :avatar
  end
end
