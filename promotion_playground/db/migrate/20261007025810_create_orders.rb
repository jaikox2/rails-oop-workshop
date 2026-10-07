class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.integer :status, null: false, default: 0
      t.references :promotion, null: true, foreign_key: true
      t.integer :subtotal_cents, null: false, default: 0
      t.integer :discount_cents, null: false, default: 0
      t.integer :total_cents, null: false, default: 0
      t.timestamps
    end
  end
end
