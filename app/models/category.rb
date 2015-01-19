class Category < ActiveRecord::Base
  has_many :meals

  validates :name, presence: true
  validates :name, uniqueness: true

end