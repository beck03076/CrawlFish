class CreateExclusiveCouponsVendorDetails < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS exclusive_coupons_vendor_details"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS exclusive_coupons_vendor_details (
  exclusive_coupon_vendor_id INT UNSIGNED NOT NULL,
  exclusive_vendor_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (exclusive_coupon_vendor_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS exclusive_coupons_vendor_details"
  end
end
