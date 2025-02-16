class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :authorize_operation

  def index
    @operations = current_user.operations.page(params[:page])
  end

  def show
  end

  def new
    @operation = current_user.operations.build
  end

  def edit
  end

  def create
    @operation = current_user.operations.build(operation_params)

    if @operation.save
      redirect_to @operation, notice: "Operation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @operation.update(operation_params)
      redirect_to @operation, notice: "Operation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @operation.destroy!

    redirect_to operations_path, status: :see_other, notice: "Operation was successfully destroyed."
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:amount, :odate, :description, :category_id)
  end

  def authorize_operation
    authorize(@operation || Operation)
  end
end
