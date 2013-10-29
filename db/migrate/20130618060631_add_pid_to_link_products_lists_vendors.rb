class AddPidToLinkProductsListsVendors < ActiveRecord::Migration
  def change
    add_column :link_products_lists_vendors, :pid, :int, :limit => 8
  end
end
