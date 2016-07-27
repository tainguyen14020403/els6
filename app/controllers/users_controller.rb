class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :index]

  def index
    @users = User.paginate(page: params[:page], per_page: Settings.page_max_users)
  end

  def show
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t("success")
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t("edit-success")
      redirect_to @user
    else
      flash.now[:danger] = t("edit-error")
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end 
end
