class AddImagePathToPlatforms < ActiveRecord::Migration[7.0]
  def change
    add_column :platforms, :image_path, :string
  end
end
