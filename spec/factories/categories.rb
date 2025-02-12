FactoryBot.define do
  factory :category do
    user
    name { Faker::Commerce.unique.department }
    description { Faker::Lorem.sentence }
  end
end
