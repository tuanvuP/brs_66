class AuthorsController < ApplicationController
  before_action :find_author, except: %i(index new create)
  before_action :find_author_book, only: :show
  before_action :load_user, except: %i(index new create)

  def index
    @authors = Author.list_author
                     .search(params[:search])
                     .page(params[:page])
                     .per Settings.per_page
  end

  def show
    @follow = current_user.active_follows.build
    @list_books = Book.author_book_by(@author)
                      .page(params[:page])
                      .per Settings.per_page
  end

  def following
    @title = t ".title"
    @authors = Author.following_author(@user)
                     .page(params[:page])
                     .per Settings.user.per_page
    render :show_author_follow
  end

  def follower_authors
    @title = t ".title"
    @users = @user.follower_authors.follower_author(@follower_author)
                  .page(params[:page])
                  .per Settings.user.per_page
    render :show_follow_author
  end

  private

  def find_author
    @author = Author.find_by id: params[:id]
    return if @author
  end

  def find_author_book
    @book = Book.find_by id: params[:author_id]
  end
end
