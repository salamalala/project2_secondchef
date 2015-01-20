class Meal < ActiveRecord::Base
  belongs_to :user # [as chef]
  belongs_to :category
  has_many :orders

  scope :available, -> { where("quantity > 0") }
  scope :tonight, -> { where("start_at < ? AND end_at > ?", Time.zone.now.midnight + 1.day, Time.zone.now) }
  scope :current, -> { where("end_at > ?", Time.zone.now) }
  scope :archived, -> { where("end_at < ?", Time.zone.now) }

  validates :category_id, :name, :description, :price, :quantity, :start_at, :end_at, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  validate :start_must_be_in_the_future
  validate :end_must_be_in_the_future
  validate :end_must_be_after_start

  def start_must_be_in_the_future
    errors.add(:start_at, "must be in the future") if start_at < Time.zone.now
  end

  def end_must_be_in_the_future
    errors.add(:end_at, "must be in the future") if end_at < Time.zone.now
  end

  def end_must_be_after_start
    errors.add(:end_at, "must be after start") if end_at < start_at
  end

  geocoded_by :chef_address
  after_validation :geocode

  def chef_address
    self.user.address
  end

  def available?
    quantity > 0
  end

  def current?
    end_at > Time.zone.now
  end

end