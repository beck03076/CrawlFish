class CreateLocalPriceListProducts < ActiveRecord::Migration
  def up

  execute <<-SQL

      CREATE TABLE local_price_list_products (
      product_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
      product_name VARCHAR(255) NOT NULL,
      product_price DOUBLE NOT NULL,
      vendor_id INT UNSIGNED NOT NULL,
      action VARCHAR(255) NOT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (product_id)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS local_price_list_products"

  end
end

