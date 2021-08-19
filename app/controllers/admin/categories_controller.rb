class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end
end
