class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :current_latitude, :float
    add_column :users, :current_longitude, :float
    add_column :users, :chef_name, :string
    add_column :users, :description, :string
    add_column :users, :image, :string
    add_column :users, :phone_number, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :postcode, :string
    add_column :users, :country, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :average_rating, :float
  end
end
