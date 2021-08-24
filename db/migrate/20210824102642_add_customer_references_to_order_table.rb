class AddCustomerReferencesToOrderTable < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :orders, :users, column: :customer_id
    add_index :orders, :customer_id
  end
end
