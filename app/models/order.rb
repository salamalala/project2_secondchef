class Order < ActiveRecord::Base
  belongs_to :user # [as user]
  belongs_to :meal
  has_one :review

end