class WordsController < ApplicationController
  before_action :check_category, only: :new

  def index
    @words = Word.paginate(page: params[:page], per_page: Settings.page_max_word)
  end

  def show
    @word = Word.find_by(id: params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash.now[:success] = t("create_word_success")
      redirect_to @word
    else
      flash[:danger] = t("create_word_fail")
      @categories = Category.all
      render :new
    end
  end

  def destroy
    @word = Word.find_by(id: params[:id])
    if @word.destroy
      flash[:success] = t("word_deleted")
      redirect_to root_path
    else
      flash[:danger] = t("delete_fail")
      redirect_to root_path
    end
  end

  private
  def word_params
    params.require(:word).permit(:content, :mean, :category_id)
  end

  def check_category
    @categories = Category.all
    if @categories.empty?
      flash[:danger] = t("categories_is_empty")
      redirect_to root_path
    end
  end
end
