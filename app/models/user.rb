class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meals # [as chef]
  has_many :orders_placed, class_name: "Order" # [as user]
  has_many :orders_received, through: :meals, source: :orders # [as chef]
  has_many :reviews, through: :orders_received # [as chef]

  validates :first_name, :last_name, presence: true

  # with_options if: :is_chef? do |chef|
  #   chef.validates :chef_name, :description, :phone_number, :address_line_1, :city, :postcode, :country, presence: true
  #   chef.validates :chef_name, length: { minimum: 2 }
  # end

  # def is_chef?
  #   self.role? "chef"
  # end
  
end
