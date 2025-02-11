class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :authorize_operation, except: %i[ new create ]

  # GET /operations or /operations.json
  def index
    @operations = current_user.operations.page(params[:page])
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @operation = current_user.operations.build
    authorize_operation
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations or /operations.json
  def create
    @operation = current_user.operations.build(operation_params)
    authorize_operation

    respond_to do |format|
      if @operation.save
        format.html { redirect_to @operation, notice: "Operation was successfully created." }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to @operation, notice: "Operation was successfully updated." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy!

    respond_to do |format|
      format.html { redirect_to operations_path, status: :see_other, notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.expect(operation: [ :amount, :odate, :description, :category_id ])
  end

  def authorize_operation
    authorize(@operation || Operation)
  end
end
