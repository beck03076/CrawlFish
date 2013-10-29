class CreateCustomerCareEntries < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS customer_care_entries"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS customer_care_entries (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  customer_name VARCHAR(255) NOT NULL,
  customer_phone_no VARCHAR(255) NOT NULL,
  customer_city VARCHAR(255) NOT NULL,
  customer_area VARCHAR(255) NOT NULL,
  customer_email VARCHAR(255) NOT NULL,
  enquiry_type VARCHAR(255) NOT NULL,
  category_enquired VARCHAR(255) NOT NULL,
  product_enquired TEXT NOT NULL,
  shops_referred TEXT NOT NULL,
  followup CHAR(1) NOT NULL,
  source VARCHAR(255) NOT NULL,
  misc TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS customer_care_entries"
  end
end
