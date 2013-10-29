class AddNameToOnlineGridDetails < ActiveRecord::Migration
  def change
    add_column :online_grid_details, :name, :string
  end
end
