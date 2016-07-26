class CategoriesController < ApplicationController
  before_action :find_category_by_id, only: :show
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.page_max_categories)
  end
  
  def show
    @words = @category.words.paginate(page: params[:page], per_page: Settings.page_max_word)
  end
  
  private
  def find_category_by_id
    @category = Category.find_by(id: params[:id])
  end
end
