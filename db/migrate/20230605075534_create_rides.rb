class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.references :user, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.integer :ETA
      t.float :fare
      t.string :category

      t.timestamps
    end
  end
end
