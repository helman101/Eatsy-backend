FactoryBot.define do
  factory :food do
    name { Faker::Food.unique.dish }
    price { 20 }
    description { Faker::Food.unique.description }
  end
end