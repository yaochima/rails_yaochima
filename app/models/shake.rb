class Shake < ApplicationRecord
  belongs_to :session
  has_many :shakes
end
