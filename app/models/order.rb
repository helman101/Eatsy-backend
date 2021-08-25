class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  has_many :food

  validates_presence_of :customer_id, :food_id, :delivered
end
