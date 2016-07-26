class WordsController < ApplicationController

  def index
    @words = Word.paginate(page: params[:page], per_page: 20)
  end

  def new
  	@word = Word.new
  end

  def create
    @word = Word.new(word_params)
  	if @word.save
  	  flash[:success] = t("create_word_success")
  	  redirect_to root_path
  	else
  	  flash.now[:danger] = t("create_word_fail")
  	end
  end

  def destroy
  	Word.find_by(id: params[:id]).destroy
    flash[:success] = t("word_deleted")
    redirect_to rootpath
  end

  private
    def word_params
  	  params.require(:word).permit(:content, :mean)
    end
end
