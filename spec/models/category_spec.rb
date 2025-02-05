require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    category = Category.new(name: "", description: "")
    it "should validate presence of name" do
      expect(category).not_to be_valid
    end
  end
end
