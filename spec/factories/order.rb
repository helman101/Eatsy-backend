FactoryBot.define do
  factory :order do
    customer_id { nil }
    food_id { nil }
    delivered { false }
  end
end