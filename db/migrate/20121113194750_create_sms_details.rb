class CreateSmsDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS sms_details"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS sms_details (
  id INT UNSIGNED AUTO_INCREMENT,
  sms_id INT UNSIGNED NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) DEFAULT 'NA',
  sub_category_name VARCHAR(255) NOT NULL,
  vendor_name VARCHAR(255) NOT NULL,
  vendor_city VARCHAR(255) NOT NULL,
  vendor_branch VARCHAR(255) NOT NULL,
  vendor_phone VARCHAR(255) NOT NULL,
  user_mobile VARCHAR(255) DEFAULT 'NA',
  user_landline VARCHAR(255) DEFAULT 'NA',
  served_to_vendor CHAR(1) DEFAULT 'N',
  served_to_user CHAR(1) DEFAULT 'N',
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (sms_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE sms_details"
  end
end

