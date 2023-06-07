class AddLinkToAppToRides < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :link_to_app, :string
  end
end
