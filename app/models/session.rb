class Session < ApplicationRecord
  has_many :guests
  has_many :shakes
end
