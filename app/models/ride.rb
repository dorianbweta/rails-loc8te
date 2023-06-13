class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :platform
  has_many :trips
  belongs_to :city

  CATEGORIES = ["economy", "green", "luxury"]
end
