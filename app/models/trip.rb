class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  belongs_to :start_location
  belongs_to :end_location
end
