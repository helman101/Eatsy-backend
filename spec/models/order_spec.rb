require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:customer).class_name('User').with_foreign_key('customer_id') }
  it { should belong_to(:food) }
  it { should validate_presence_of(:customer_id) }
  it { should validate_presence_of(:food_id) }
end