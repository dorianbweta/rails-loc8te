class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :platform
  has_many :trips

  CATEGORIES = ["economy", "green", "luxury"]
end
