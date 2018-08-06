class CategoriesController < ApplicationController
  before_action :load_category, except: %i(index new create)

  def index
    @categories = Category.list_category
                          .page(params[:page])
                          .per Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to categories_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to categories_path
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit :title, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".danger"
    redirect_to categories_path
  end
end
