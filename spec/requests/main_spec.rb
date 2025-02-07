require "rails_helper"

RSpec.describe "Main", type: :request do
  describe "index" do
    it "should visit index page" do
      get main_index_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it "should be a root page" do
      get root_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end
end
