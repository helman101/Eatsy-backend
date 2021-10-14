class Food < ApplicationRecord
  
mount_uploader :image, ImageUploader
  has_many :orders
  validates_presence_of :name, :price, :description
end
