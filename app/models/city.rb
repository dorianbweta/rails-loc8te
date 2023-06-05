class City < ApplicationRecord
  has_many :platform_cities
  has_many :platforms, through: :platform_cities
  has_many :rides
end
