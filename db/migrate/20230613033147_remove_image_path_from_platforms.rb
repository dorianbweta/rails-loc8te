class RemoveImagePathFromPlatforms < ActiveRecord::Migration[7.0]
  def change
    remove_column :platforms, :image_path, :string
  end
end
