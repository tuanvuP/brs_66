class FollowsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: %i(create destroy)
  before_action :check_user

  def create
    @follow = Follow.new follow_params
    if @follow.save!
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  def destroy
    @follow = Follow.find_by id: params[:id]
    if @follow.destroy
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  def create_author
    @author = Author.find_by id: params[:create_author][:follower_id]
    @follow = Follow.new follow_author_params
    if @follow.save!
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  def destroy_author
    @author = Author.find_by id: params[:destroy_author][:follower_id]
    @follow = Follow.find_by id: params[:id]
    if @follow.destroy
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  def create_book
    @book = Book.find_by id: params[:create_book][:follower_id]
    @follow = Follow.new follow_book_params
    if @follow.save!
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  def destroy_book
    @book = Book.find_by id: params[:destroy_book][:follower_id]
    @follow = Follow.find_by id: params[:id]
    if @follow.destroy
      respond_to do |format|
        format.html {redirect_to @follow}
        format.js
      end
    end
  end

  private

  def follow_params
    params.require(:follow).permit :user_id, :type_follow, :follower_id
  end

  def follow_author_params
    params.require(:create_author).permit :user_id, :type_follow, :follower_id
  end

  def follow_book_params
    params.require(:create_book).permit :user_id, :type_follow, :follower_id
  end

  def find_user
    @user = User.find_by id: params[:follow][:follower_id]
    return if @user
  end

  def check_user
    return if user_signed_in?
  end
end
