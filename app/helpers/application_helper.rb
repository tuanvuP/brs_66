module ApplicationHelper
  def create_index params_page, index, per_page
    params_page = 1 if params_page.nil?
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def unfollow_user
    unfollow_user = current_user.active_follows.find_by follower_id: @user.id
  end

  def unfollow_author
    unfollow_author = current_user.active_follows.find_by follower_id: @author.id
  end

  def unfollow_book
    unfollow_book = current_user.active_follows.find_by follower_id: @book.id
  end

  def list_categories
    @categories = @categories.map{|key, value| [key, value]}
  end
end
