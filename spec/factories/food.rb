FactoryBot.define do
  factory :food do
    name { Faker::Food.dish }
    price { 20 }
    description { Faker::Food.description }
  end
end