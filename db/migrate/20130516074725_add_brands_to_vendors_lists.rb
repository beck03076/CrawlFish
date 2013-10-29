class AddBrandsToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :brands, :text
  end
end
