class Meal < ActiveRecord::Base
  belongs_to :user # [as chef]
  belongs_to :category
  has_many :orders

  validates :category_id, :name, :description, :price, :quantity, :start_at, :end_at, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  # validates :start_at > Time.zone.now
  # validates :end_at > :start_at

end