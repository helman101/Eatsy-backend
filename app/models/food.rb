class Food < ApplicationRecord
  has_many :orders, class_name: 'Order', foreign_key: 'food_id'
  validates_presence_of :name, :price, :description
end
