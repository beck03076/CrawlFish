class AddLandmarkToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :landmark, :string
  end
end
