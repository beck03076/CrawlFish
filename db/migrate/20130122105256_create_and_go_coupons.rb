class CreateAndGoCoupons < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS and_go_coupons"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS and_go_coupons (
  and_go_coupon_id BIGINT UNSIGNED AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  price double NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  coupon_code VARCHAR(255) NOT NULL,
  customer_phone_number VARCHAR(255) NOT NULL,
  sub_category_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (and_go_coupon_id),
  UNIQUE (vendor_id,coupon_code)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE and_go_coupons"
  end
end
