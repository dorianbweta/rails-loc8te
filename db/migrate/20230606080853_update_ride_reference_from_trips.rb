class UpdateRideReferenceFromTrips < ActiveRecord::Migration[7.0]
  def change
    change_column_null :trips, :ride_id, true
  end
end
