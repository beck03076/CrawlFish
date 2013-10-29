class CreateVendorCoupons < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS vendor_coupons"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_coupons (
  coupon_id BIGINT UNSIGNED AUTO_INCREMENT,
  unique_id BIGINT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  coupon_code VARCHAR(255) NOT NULL,
  customer_phone_number VARCHAR(255) NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (coupon_id),
  UNIQUE (vendor_id,coupon_code)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE vendor_coupons"
  end
end
