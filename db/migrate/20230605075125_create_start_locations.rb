class CreateStartLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :start_locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
