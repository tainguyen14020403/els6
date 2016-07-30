class Admin::WordsController < ApplicationController
  before_action :admin_user, :logged_in_user
  before_action :check_category, only: :new
  before_action :find_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = Word.paginate(page: params[:page], per_page: Settings.page_max_word)
  end

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:success] = t("create_word_success")
      redirect_to [:admin, @word]
    else
      flash.now[:danger] = t("create_word_fail")
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes(word_params)
      flash[:success] = t("update_word_success")
      redirect_to [:admin, @word]
    else
      flash.now[:danger] = t("update_word_fail")
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t("word_deleted")
      redirect_to admin_words_path
    else
      flash[:danger] = t("delete_fail")
      redirect_to admin_words_path
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
      redirect_to new_admin_category_path
    end
  end

  def find_word
    @word = Word.find_by(id: params[:id])
  end
end
