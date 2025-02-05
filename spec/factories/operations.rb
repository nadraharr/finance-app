FactoryBot.define do
  factory :operation do
    category
    description { "MyString" }
    odate { "2025-02-05 16:54:17" }
    amount { "9.99" }
  end
end
