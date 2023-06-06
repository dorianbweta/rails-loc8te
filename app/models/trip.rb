class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  belongs_to :start_location, class_name: "Location"
  belongs_to :end_location, class_name: "Location"
end
