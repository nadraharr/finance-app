FactoryBot.define do
  factory :operation do
    category
    description { Faker::Lorem.sentence }
    odate { Faker::Time.backward(days: 14, period: :evening) }
    amount { Faker::Commerce.price }
  end
end
