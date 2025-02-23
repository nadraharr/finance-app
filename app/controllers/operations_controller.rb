class OperationsController < ApplicationController
  before_action :set_operation, only: %i[edit update destroy]
  before_action :authorize_operation

  def index
    @operations = current_user.operations.page(params[:page]).order(created_at: :desc)
  end

  def new
    @operation = current_user.operations.build

    render turbo_stream: turbo_stream.update("newModal-content", partial: "form", locals: { operation: @operation })
  end

  def create
    @operation = current_user.operations.build(operation_params)

    if @operation.save
      redirect_to operations_path, notice: "Operation was successfully created."
    else
      render turbo_stream: turbo_stream.replace("new_operation-errors", partial: "shared/errors", locals: { object: @operation })
    end
  end

  def edit
    render turbo_stream: turbo_stream.update("editModal-content", partial: "form", locals: { operation: @operation })
  end

  def update
    if @operation.update(operation_params)
      redirect_to operations_path, notice: "Operation was successfully updated."
    else
      render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@operation)}-errors", partial: "shared/errors",
                                                                                        locals: { object: @operation })
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
