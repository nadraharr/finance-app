class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]
  before_action :authorize_category

  def index
    @categories = current_user.categories.page(params[:page]).order(created_at: :desc)
  end

  def new
    @category = current_user.categories.build

    render turbo_stream: turbo_stream.update("newModal-content", partial: "form", locals: { category: @category })
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render turbo_stream: turbo_stream.replace("new_category-errors", partial: "shared/errors", locals: { object: @category })
      head :unprocessable_entity
    end
  end

  def edit
    render turbo_stream: turbo_stream.update("editModal-content", partial: "form", locals: { category: @category })
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@category)}-errors", partial: "shared/errors",
                                                                                       locals: { object: @category })
      head :unprocessable_entity
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
