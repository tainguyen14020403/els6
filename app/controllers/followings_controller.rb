class FollowingsController < ApplicationController
  def index
    @title = t("following")
    @user  = User.find_by(id: params[:user_id])
    @users =  @user.following
    @followings = @users.paginate(page: params[:page], per_page: Settings.page_max_users)
  end
end
