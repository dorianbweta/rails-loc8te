class DropStartLocations < ActiveRecord::Migration[7.0]
  def change
    drop_table :start_locations
  end
end
