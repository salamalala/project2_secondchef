class Order < ActiveRecord::Base
  belongs_to :user # [as user]
  belongs_to :meal
  has_one :review

  scope :current, -> { where("fetch_at > ?", Time.zone.now - 1.hour)}
  scope :archived, -> { where("fetch_at < ?", Time.zone.now - 1.hour)}

  validates :user_id, :meal_id, :price, :quantity, :fetch_at, :credit_card_number, :credit_card_name, :credit_card_expiry, presence: true
  # validates :quantity <= self.meal.quantity
  # validates :price == self.meal.price
  # validates :fetch_at >= :start_at
  # validates :fetch_at <= :end_at
  # validates credit card details

end