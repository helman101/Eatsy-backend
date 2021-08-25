class Food < ApplicationRecord
  belongs_to :order

  validates_presence_of :name, :price, :description
end
