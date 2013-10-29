class CreateExclusiveCoupons < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS exclusive_coupons"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS exclusive_coupons (
  exclusive_coupon_id BIGINT UNSIGNED AUTO_INCREMENT,
  exclusive_coupon_vendor_id INT UNSIGNED NOT NULL,
  exclusive_vendor_name VARCHAR(255) NOT NULL,
  exclusive_coupon_code VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (exclusive_coupon_id),
  UNIQUE (exclusive_coupon_vendor_id,exclusive_coupon_code)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS exclusive_coupons"
  end
end
