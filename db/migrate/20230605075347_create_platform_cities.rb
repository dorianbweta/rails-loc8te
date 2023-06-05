class CreatePlatformCities < ActiveRecord::Migration[7.0]
  def change
    create_table :platform_cities do |t|
      t.references :platform, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
