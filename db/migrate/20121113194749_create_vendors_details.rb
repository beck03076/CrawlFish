class CreateVendorsDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendors_details"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendors_details (
  id INT UNSIGNED AUTO_INCREMENT,
  vendor_id INT UNSIGNED NOT NULL,
  vendor_name VARCHAR(255),
  vendor_phone VARCHAR(255),
  vendor_city VARCHAR(255),
  vendor_branch VARCHAR(255),
  vendor_contact_name VARCHAR(255) DEFAULT "Merchant",
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (vendor_id, vendor_phone)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendors_details"
  end
end

