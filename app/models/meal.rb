class Meal < ActiveRecord::Base
  belongs_to :user # [as chef]
  belongs_to :category
  has_many :orders

end