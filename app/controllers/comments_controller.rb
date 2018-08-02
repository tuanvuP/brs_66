class CommentsController < ApplicationController
  before_action :load_comment, only: %i(edit update destroy)
  before_action :logged_in_user, expect: :index

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save!
      respond_to do |format|
        format.html {redirect_to @comment.book}
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :book_id, :user_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".danger"
    redirect_back fallback_location: root_path
  end
end
