require "rails_helper"

RSpec.describe Operation, type: :model do
  subject(:operation) { build(:operation) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:odate) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
