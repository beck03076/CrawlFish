class CreateLocalPriceListDetails < ActiveRecord::Migration
  def up

  execute <<-SQL

      CREATE TABLE local_price_list_details (
      id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
      brand_name VARCHAR(255) NOT NULL,
      vendor_id INT UNSIGNED NOT NULL,
      brand_logo VARCHAR(255) NOT NULL,
      distributor_name VARCHAR(255) NOT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (id),  
      UNIQUE (vendor_id,brand_name)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS local_price_list_details"

  end
end

