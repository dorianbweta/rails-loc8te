class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ride, null: false, foreign_key: true
      t.references :start_location, null: false, foreign_key: true
      t.references :end_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
