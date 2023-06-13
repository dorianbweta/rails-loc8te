class RemoveCityReferencesFromRides < ActiveRecord::Migration[7.0]
  def change
    remove_reference :rides, :city, null: false, foreign_key: true
  end
end
