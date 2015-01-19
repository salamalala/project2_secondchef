class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :quantity
      t.datetime :start_at
      t.datetime :end_at
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
