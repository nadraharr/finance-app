class User < ApplicationRecord
  has_secure_password
  has_many :categories
  has_many :operations
  validates :email, presence: true, uniqueness: true
end
