class AddCatBranToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :cat_bran, :string, :limit =>1000 
  end
end
