class Category < ApplicationRecord
  has_many :operations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
