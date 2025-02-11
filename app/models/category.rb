class Category < ApplicationRecord
  belongs_to :user
  has_many :operations, dependent: :nullify
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, presence: true
end
