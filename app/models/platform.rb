class Platform < ApplicationRecord
  has_many :platform_cities
  has_many :cities, through: :platform_cities
  has_many :rides
end
