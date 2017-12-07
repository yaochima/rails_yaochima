class Restaurant < ApplicationRecord
  has_many :shakes

  geocoded_by :restaurants, :latitude  => :lat, :longitude => :lng
end
