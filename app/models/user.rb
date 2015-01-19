class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meals # [as chef]
  has_many :orders_placed, class_name: "Order" # [as user]
  has_many :orders_received, through: :meals, source: :orders # [as chef]
  has_many :reviews, through: :orders_received # [as chef]

end
