class AddReferencesToTrips < ActiveRecord::Migration[7.0]
  def change
    add_reference :trips, :start_location, null: false, foreign_key: {to_table: :locations}
    add_reference :trips, :end_location, null: false, foreign_key: {to_table: :locations}
  end
end
