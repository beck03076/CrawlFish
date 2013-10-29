class CreateVendorsLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS vendors_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS vendors_lists (
  vendor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  vendor_name VARCHAR(255) NOT NULL,
  vendor_alias_name VARCHAR(255),
  vendor_logo TEXT NOT NULL,
  vendor_description TEXT NOT NULL,
  business_type VARCHAR(255) NOT NULL,
  vendor_website VARCHAR(255) DEFAULT "na",
  vendor_email VARCHAR(255) DEFAULT "na",
  vendor_phone VARCHAR(255) NOT NULL,
  vendor_fax VARCHAR(255) DEFAULT "na",
  vendor_address TEXT NOT NULL,
  latitude VARCHAR(255) DEFAULT "na",
  longitude VARCHAR(255) DEFAULT "na",
  city_name VARCHAR(255) NOT NULL,
  branch_name VARCHAR(255) NOT NULL,
  branch_alias_name VARCHAR(255),
  working_time TEXT,
  miscellaneous TEXT,
  vendor_speciality_store VARCHAR(255) DEFAULT "na",
  established_year VARCHAR(255) DEFAULT "na",
  vendor_sub_categories VARCHAR(500) NOT NULL,
  affiliate_id VARCHAR(100) DEFAULT "0",
  monetization_type VARCHAR(255) NOT NULL,
  subscribed_date DATE NOT NULL,
  trial_flag CHAR(1) DEFAULT "n",
  vendor_rating INT UNSIGNED DEFAULT "0",
  blocked_flag INT UNSIGNED DEFAULT "0",
  discarded_flag INT UNSIGNED 	DEFAULT "0",
  sponsored_seller_flag CHAR(1) DEFAULT "n",
  freeze_flag CHAR(1) DEFAULT "n",
  enquiry_no VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (vendor_id),
  UNIQUE (vendor_name,business_type,city_name,branch_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE vendors_lists"
  end
end

