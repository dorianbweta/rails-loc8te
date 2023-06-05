class CreateEndLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :end_locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
