class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find_by(id: params[:id])
    @category = Category.find_by(id: params[:category_id])
    @words = @category.words.words_in_lesson(params[:id])
  end

  def create
    @lesson = Lesson.new(category_id: params[:category_id], user_id: current_user.id)
    @category = Category.find_by(id: params[:category_id])
    if @lesson.save
      flash[:success] = t("lesson-create-success")
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t("lesson-create-fail")
      redirect_to categories_path
    end
  end
end
