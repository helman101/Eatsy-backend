FactoryBot.define do
  factory :order do
    customer_id { 1 }
    food_id { 1 }
    delivered { false }
  end
end