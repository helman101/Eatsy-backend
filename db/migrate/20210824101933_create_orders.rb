class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :food_id
      t.boolean :delivered

      t.timestamps
    end
  end
end
