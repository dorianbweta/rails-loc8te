class DropEndLocations < ActiveRecord::Migration[7.0]
  def change
    drop_table :end_locations
  end
end
