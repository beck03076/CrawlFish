class AddCIdToVendorCoupons < ActiveRecord::Migration
  def change
    add_column :vendor_coupons, :c_id, :integer
  end
end
