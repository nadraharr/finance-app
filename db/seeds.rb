# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = User.create!(
  email: "admin@test.com",
  password: "password",
  password_confirmation: "password",
  # role: "admin"
)

user = User.create!(
  email: "user@test.com",
  password: "password",
  password_confirmation: "password",
  # role: "user"
)

def create_data_for(user)
  categories = []

  20.times do
    categories << Category.create!(
      name: Faker::Commerce.unique.department,
      description: Faker::Lorem.sentence,
      user: user,
    )
  end

  200.times do
    Operation.create!(
      amount: Faker::Commerce.price(range: 5..500),
      odate: Faker::Time.backward(days: 30, period: :evening),
      description: Faker::Lorem.sentence,
      category: categories.sample,
      user: user,
    )
  end
end

create_data_for(admin)
create_data_for(user)
