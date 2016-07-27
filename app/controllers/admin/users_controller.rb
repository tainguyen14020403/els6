class Admin::UsersController < ApplicationController
  before_action :find_user, only: :destroy
  before_action :admin_user, :logged_in_user

  def index
    @users = User.paginate(page: params[:page], per_page: Settings.page_max_users)
  end
  
  def destroy
    if @user.destroy
      flash[:success] = t("delete-user-success")
    else
      flash[:danger] = t("delete-user-fail")
    end
    redirect_to admin_users_url
  end

  private
  def find_user
    @user = User.find_by(id: params[:id])
  end
end
