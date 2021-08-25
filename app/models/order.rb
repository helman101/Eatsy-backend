class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :food

  validates_presence_of :customer_id, :food_id
end
