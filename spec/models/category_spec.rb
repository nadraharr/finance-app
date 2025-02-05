require "rails_helper"

RSpec.describe Category, type: :model do
  # describe "validations" do
  #   category = Category.new(name: "", description: "")
  #   it "should validate presence of name" do
  #     expect(category).not_to be_valid
  #   end
  # end

  describe "associations" do
    it { should have_many(:operations) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
