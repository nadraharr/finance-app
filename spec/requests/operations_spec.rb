require "rails_helper"

RSpec.describe "Operations", type: :request do
  let(:operation) { create(:operation, description: "Some Payment") }

  describe "index" do
    it "should visit operations page" do
      get operations_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe "show" do
    it "should visit operation page" do
      get operation_path(operation)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe "new" do
    it "should visit new operation page" do
      get new_operation_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "create" do
    context "with valid params" do
      it "should create operation" do
        category = create(:category)
        valid_params = attributes_for(:operation, category_id: category.id)
        expect { post operations_path, params: { operation: valid_params } }.to change { Operation.count }.by(1)
        expect(response).to redirect_to operation_path(Operation.last)
      end
    end

    context "with invalid params" do
      it "should not create operation" do
        invalid_params = attributes_for(:operation, description: "")
        expect { post operations_path, params: { operation: invalid_params } }.to_not change { Operation.count }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "edit" do
    it "should visit edit page" do
      get edit_operation_path(operation)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "update" do
    context "with valid params" do
      it "should update operation" do
        valid_params = { description: "Valid Description" }
        patch operation_path(operation), params: { operation: valid_params }
        expect(operation.reload.description).to eq("Valid Description")
        expect(response).to redirect_to(operation_path(operation))
      end
    end

    context "with invalid params" do
      it "should not update operation" do
        invalid_params = { description: "" }
        patch operation_path(operation), params: { operation: invalid_params }
        expect(operation.reload.description).to eq("Some Payment")
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "destroy" do
    it "should delete operation" do
      operation_to_delete = operation
      expect { delete operation_path(operation_to_delete) }.to change { Operation.count }.by(-1)
      expect(response).to redirect_to(operations_path)
    end
  end
end
