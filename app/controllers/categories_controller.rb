class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authorize_category

  def index
    @categories = current_user.categories.page(params[:page])
  end

  def show
  end

  def new
    @category = current_user.categories.build
  end

  def edit
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      respond_to do |format|
        format.html { redirect_to categories_path, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      respond_to do |format|
        format.html { redirect_to categories_path, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @category.destroy!

    redirect_to categories_path, status: :see_other, notice: "Category was successfully destroyed."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def authorize_category
    authorize(@category || Category)
  end
end
