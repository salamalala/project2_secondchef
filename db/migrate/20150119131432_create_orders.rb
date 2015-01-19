class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :meal_id
      t.decimal :price
      t.integer :quantity
      t.datetime :fetch_at
      t.string :comments
      t.string :credit_card_number
      t.string :credit_card_name
      t.date :credit_card_expiry

      t.timestamps
    end
  end
end
