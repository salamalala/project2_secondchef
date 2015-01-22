class Order < ActiveRecord::Base
  belongs_to :user # [as user]
  belongs_to :meal
  has_one :review

  scope :current, -> { where("fetch_at > ?", Time.zone.now - 1.hour)}
  scope :archived, -> { where("fetch_at < ?", Time.zone.now - 1.hour)}

  validates :user_id, :meal_id, :price, :quantity, :fetch_at, :credit_card_number, :credit_card_name, :credit_card_expiry, presence: true

  validate :quantity_must_not_exceed_meal_quantity
  validate :price_must_equal_meal_price
  validate :fetch_must_be_after_start
  validate :fetch_must_be_before_end
  validate :expiry_must_be_after_today

  def quantity_must_not_exceed_meal_quantity
    errors.add(:quantity, "must not exceed meal quantity") if !quantity.blank? && quantity > self.meal.quantity
  end

  def price_must_equal_meal_price
    errors.add(:price, "must equal meal price") if (quantity.to_f - self.meal.price.to_f) > 0.01
  end

  def fetch_must_be_after_start
    errors.add(:fetch_at, "must be after start") if fetch_at < self.meal.start_at
  end

  def fetch_must_be_before_end
    errors.add(:fetch_at, "must be before end") if fetch_at > self.meal.end_at
  end

  def expiry_must_be_after_today
    if credit_card_expiry
    errors.add(:credit_card_expiry, "must be after today") if credit_card_expiry < Date.tomorrow
    end
  end

  def total
    quantity * price
  end

end