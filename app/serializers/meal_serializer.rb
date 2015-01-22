class MealSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :price_text, :distance_text, :url

  def price_text
    "£#{object.price}"
  end

  def distance_text
    "#{object.distance.round(1)} miles"
  end

  def url
    "/meals/#{object.id}"
  end

end
