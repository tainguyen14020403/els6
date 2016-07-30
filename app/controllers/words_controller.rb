class WordsController < ApplicationController
  before_action :check_category, only: :new

  def index
    @words = Word.paginate(page: params[:page], per_page: Settings.page_max_word)
  end

  def show
    @word = Word.find_by(id: params[:id])
  end
end
