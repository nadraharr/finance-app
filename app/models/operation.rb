class Operation < ApplicationRecord
  belongs_to :category
  validates :amount, numericality: { greater_than: 0 }
  validates :odate, :description, presence: true
end
