class Food < ApplicationRecord
  has_many :orders
  validates_presence_of :name, :price, :description
end
