class Operation < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :amount, numericality: { greater_than: 0 }
  validates :odate, :description, presence: true
end
