FactoryBot.define do
  factory :category do
    name { Faker::Commerce.unique.department }
    description { Faker::Lorem.sentence }
  end
end
