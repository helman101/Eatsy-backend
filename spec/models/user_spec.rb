require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:orders).with_foreign_key('customer_id') }
  it { should have_secure_password }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should allow_value('email@addresse.foo').for(:email) }
  it { should_not allow_value('foo').for(:email) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email) }
end