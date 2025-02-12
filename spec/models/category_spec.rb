require "rails_helper"

RSpec.describe Category, type: :model do
  subject(:category) { build(:category) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:operations).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
