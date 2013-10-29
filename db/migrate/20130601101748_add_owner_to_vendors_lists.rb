class AddOwnerToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :owner, :string
  end
end
