class CreatePromotions < ActiveRecord::Migration[8.1]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.boolean :active, null: false, default: true
      t.integer :amount_cents
      t.integer :percentage
      t.integer :minimum_spend_cents
      t.integer :maximum_discount_cents
      t.integer :minimum_quantity
      t.timestamps
    end

    add_index :promotions, :type
  end
end
