class Admin::CategoriesController < ApplicationController
  before_action :admin_user, :logged_in_user
  before_action :find_category , only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.page_max_categories)
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("category-success-create")
      redirect_to admin_categories_url
    else
      flash.now[:danger] = t("category-error-create")
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @category.update_attributes(category_params)
      flash[:success] = t("category-success-update")
      redirect_to admin_categories_url
    else
      flash.now[:danger] = t("category-error-update")
      render :edit
    end
  end
  
  def destroy
    if @category.destroy
      flash[:success] = t("category-success-destroy")
    else
      flash[:danger] = t("category-error-destroy")
    end
    redirect_to admin_categories_url
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def find_category
    @category = Category.find_by(id: params[:id])
  end
  
end
