class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order("created_at DESC")
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.save!
    redirect_to @category, notice: 'Category was successfully created.'
  end

  def update
    if @category.update(category_params)
       redirect_to @category, notice: 'Category was successfully updated.'
    else
       render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
