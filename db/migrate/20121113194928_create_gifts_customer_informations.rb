class CreateGiftsCustomerInformations < ActiveRecord::Migration
  def up

  execute <<-SQL

  CREATE TABLE gifts_customer_informations (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT,
      gift_id INT UNSIGNED NOT NULL,      
      gift_name VARCHAR(255) NOT NULL,
      coupon_code VARCHAR(255) NOT NULL,
      customer_name VARCHAR(255) NOT NULL,
      customer_address TEXT NOT NULL,
      customer_phone_number VARCHAR(255) NOT NULL,
      invoice_number TEXT NOT NULL,
      vendor_name TEXT DEFAULT NULL,
      vendor_branch_name VARCHAR(255) DEFAULT NULL,
      vendor_city_name VARCHAR(255) DEFAULT NULL,
      vendor_phone_number VARCHAR(255) DEFAULT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (id)  
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS gifts_customer_informations"

  end

end
