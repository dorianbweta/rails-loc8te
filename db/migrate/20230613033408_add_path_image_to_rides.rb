class AddPathImageToRides < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :path_image, :string
  end
end
