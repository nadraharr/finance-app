require "rails_helper"

RSpec.describe Category, type: :model do
  subject(:category) { build(:category) }

  describe "associations" do
    it { should have_many(:operations) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
