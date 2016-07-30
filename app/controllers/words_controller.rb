class WordsController < ApplicationController
  before_action :check_category, only: :new

  def index
    @categories = Category.all
    if params[:category] && params[:option]
      @category = Category.find_by(id: params[:category]) 
      if params[:option] == t("radio_learn")
        @words = @category.words.learned(current_user.id)
      elsif params[:option] == t("radio_not_learn")
        @words = @category.words.not_learned(current_user.id)
      else
        @words = @category.words
      end
      @words = @words.paginate(page: params[:page], per_page: Settings.page_max_word)
    end
  end

  def show
    @word = Word.find_by(id: params[:id])
  end
end
