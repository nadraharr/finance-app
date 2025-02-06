require "rails_helper"

RSpec.describe "Categories", type: :request do
  let(:category) { create(:category, name: "Groceries") }

  describe "index" do
    it "should visit categories page" do
      get categories_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe "show" do
    it "should visit category page" do
      get category_path(category)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe "new" do
    it "should visit new page" do
      get new_category_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "create" do
    context "valid params" do
      it "should create category" do
        valid_params = attributes_for(:category)
        expect { post categories_path, params: { category: valid_params } }.to change { Category.count }.by(1)
        expect(response).to redirect_to category_path(Category.last)
      end
    end

    context "invalid params" do
      it "should not create category" do
        invalid_params = attributes_for(:category, name: "")
        expect { post categories_path, params: { category: invalid_params } }.to_not change { Category.count }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "edit" do
    it "should visit edit page" do
      get edit_category_path(category)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "update" do
    context "valid params" do
      it "should update category" do
        valid_params = { name: "Meds" }
        patch category_path(category), params: { category: valid_params }
        expect(category.reload.name).to eq("Meds")
        expect(response).to redirect_to(category_path(category))
      end
    end

    context "invalid params" do
      it "should not update category" do
        invalid_params = { name: "" }
        patch category_path(category), params: { category: invalid_params }
        expect(category.reload.name).to eq("Groceries")
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "destroy" do
    it "should delete category" do
      category_to_delete = category
      expect { delete category_path(category_to_delete) }.to change { Category.count }.by(-1)
      expect(response).to redirect_to(categories_path)
    end
  end
end
