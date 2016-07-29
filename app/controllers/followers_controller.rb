class FollowersController < ApplicationController
  def index
    @title = t("follower")
    @user  = User.find_by(id: params[:user_id])
    @users = @user.followers
    @followers = @users.paginate(page: params[:page], per_page: Settings.page_max_users)
  end
end
