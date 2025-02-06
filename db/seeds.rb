# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do
  Category.find_or_create_by!(
    name: Faker::Commerce.unique.department,
    description: Faker::Lorem.sentence,
  )
end

100.times do
  Operation.find_or_create_by!(
    amount: Faker::Commerce.price,
    odate: Faker::Time.backward(days: 14, period: :evening),
    description: Faker::Lorem.sentence,
    category_id: Category.pluck(:id).sample,
  )
end
