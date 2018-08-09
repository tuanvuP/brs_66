class FollowsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by follower_id: params[:follower_id]
    current_user.follow user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    user = Follow.find_by(follower_id: params[:follower_id]).user_id
    current_user.unfollow user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
