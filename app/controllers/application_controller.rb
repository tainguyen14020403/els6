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
    unless current_user.admin?
      flash[:danger] =  t("admin_require")
      redirect_to(root_url)
    end
  end

  def find_word_in_lesson(lesson_id)
    @lesson = Lesson.find_by(id: lesson_id)
    @category = @lesson.category
    @words = @category.words.words_in_lesson(@lesson.id)
  end
end
