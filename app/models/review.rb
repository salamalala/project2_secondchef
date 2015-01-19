class Review < ActiveRecord::Base
  belongs_to :order

  validates :rating, :user_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

end