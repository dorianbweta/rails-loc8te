class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :platform
  belongs_to :city
  has_many :trips

  CATEGORIES = ["economy", "green", "luxury"]
end
