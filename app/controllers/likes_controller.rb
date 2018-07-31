class LikesController < ApplicationController
  before_action :logged_in_user, expect: :index

  def create
    @book = Book.find_by id: params[:book_id]
    if current_user.like @book
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t ".danger"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    if @book = @like.book
      @like.destroy
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t ".danger"
      redirect_back fallback_location: root_path
    end
  end
end
