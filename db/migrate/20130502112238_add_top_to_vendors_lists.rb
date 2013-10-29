class AddTopToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :top, :integer,{:default=>0}
  end
end
