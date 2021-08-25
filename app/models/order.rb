class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'

  validates_presence_of :customer_id, :food_id, :delivered
end
