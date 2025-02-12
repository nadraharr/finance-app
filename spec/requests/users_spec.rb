require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "new" do
    it "renders the new template" do
      get new_user_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "create" do
    context "with valid params" do
      it "creates a new user and signs them in" do
        valid_params = attributes_for(:user)

        expect {
          post users_path, params: { user: valid_params }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "with invalid params" do
      it "does not create a new user" do
        invalid_params = attributes_for(:user, email: "")

        expect {
          post users_path, params: { user: invalid_params }
        }.to_not change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "edit" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it "renders the edit template" do
      get edit_user_path(user)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "update" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context "with valid params" do
      it "updates the user" do
        valid_params = { name: "Updated Name" }
        patch user_path(user), params: { user: valid_params }

        expect(user.reload.name).to eq("Updated Name")
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "does not update the user" do
        invalid_params = { email: "" }
        patch user_path(user), params: { user: invalid_params }

        expect(user.reload.email).not_to eq("")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
