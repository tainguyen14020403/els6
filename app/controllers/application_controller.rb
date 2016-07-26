class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t("request")
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
