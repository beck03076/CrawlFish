class CreateVendorCouponsDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendor_coupons_details"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendor_coupons_details (
  id INT UNSIGNED AUTO_INCREMENT,
  coupon_id BIGINT UNSIGNED NOT NULL,
  coupon_code VARCHAR(255) NOT NULL,
  sub_category_name VARCHAR(255) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) NOT NULL,
  vendor_name VARCHAR(255) NOT NULL,
  vendor_branch_name VARCHAR(255) NOT NULL,
  vendor_city_name VARCHAR(255) NOT NULL,
  vendor_phone_number VARCHAR(255) NOT NULL,
  customer_phone_number VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE vendor_coupons_details"
  end
end
