class RemoveForeignKeysFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_reference(:trips, :start_location, index: true, foreign_key: true)
    remove_reference(:trips, :end_location, index: true, foreign_key: true)
  end
end
