class User < ApplicationRecord
  has_many :orders, class_name: 'Order', foreign_key: 'customer_id'
  has_secure_password

  validates_presence_of :name, :email, :password, :password_confirmation
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :name, :email
end
