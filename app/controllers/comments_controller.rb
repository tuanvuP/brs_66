class CommentsController < ApplicationController
  before_action :load_comment, except: %i(index new create)
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

  def edit
    respond_to do |format|
      format.html {redirect_to @comment.book}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html {redirect_to @comment.book}
        format.js
      end
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to @comment.book}
        format.js
      end
    end
  end

  def new_reply
    respond_to do |format|
      format.html {redirect_to @comment.book}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :book_id, :user_id, :parent_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".danger"
    redirect_back fallback_location: root_path
  end
end
