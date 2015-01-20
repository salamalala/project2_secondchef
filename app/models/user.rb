class User < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  # mount_uploader :chef_image, ChefImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :meals # [as chef]
  has_many :orders_placed, class_name: "Order" # [as user]
  has_many :orders_received, through: :meals, source: :orders # [as chef]
  has_many :reviews, through: :orders_received # [as chef]

  validates :first_name, :last_name, presence: true

  with_options if: :is_chef? do |chef|
    chef.validates :chef_name, :description, :phone_number, :address_line_1, :city, :postcode, :country, presence: true
    chef.validates :chef_name, length: { minimum: 2 }
  end

  def is_chef?
    self.role? "chef"
  end

  geocoded_by :address
  after_validation :geocode

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def name
    first_name + " " + last_name
  end

  def address
    [address_line_1, address_line_2, city, postcode, country].reject(&:blank?).join(", ")
  end

  def set_rating
    ratings = self.reviews.map(&:rating)
    average = ratings.inject(:+).to_f / ratings.size
    if average.is_a? Float
      self.average_rating = average
      self.save
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(first_name:auth.extra.raw_info.first_name,
          last_name:auth.extra.raw_info.last_name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20],
          )
      end
    end
  end
  
end
