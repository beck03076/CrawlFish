class AddPocToVendorsLists < ActiveRecord::Migration
  def change
    add_column :vendors_lists, :poc, :string
  end
end
