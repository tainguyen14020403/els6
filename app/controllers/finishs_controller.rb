class FinishsController < ApplicationController
  def show
    @words = find_word_in_lesson(params[:id])
    @results = []
    @words.each do |word|
      result = Result.find_by(user_id: current_user.id, lesson_id: @lesson.id, word_id: word.id)
      @results << result
    end
  end

  def index
    @lessons = current_user.lessons
    @results = []
    @lessons.each do |lesson|
      result = Result.where("lesson_id = ?", lesson.id)
      @results << result
    end
  end

  def create
    @words = find_word_in_lesson(params[:lesson_id])
    @result = 0
    @words.each do |word|
      word_id = word.id.to_s
      if params[:finish]
        if word.mean == params[:finish][word_id]
          update_result(current_user.id, @lesson.id, word.id, 1)
          @result = @result + 1
          @lesson.update_attribute(:result, @result)
        else
          update_result(current_user.id, @lesson.id, word.id, 0)
        end
      else
        update_result(current_user.id, @lesson.id, word.id, 0)
      end
    end
    redirect_to finish_path(id: @lesson.id)
  end

  private
  def update_result(user_id, lesson_id, word_id, status)
    result = Result.find_by(user_id: user_id, lesson_id: lesson_id, word_id: word_id)
    result.update_attribute(:status, status)
  end
end
