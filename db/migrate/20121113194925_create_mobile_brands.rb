class CreateMobileBrands < ActiveRecord::Migration

  def up

  execute <<-SQL

  CREATE TABLE mobile_brands (
      mobile_brands_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
      mobile_brand_name VARCHAR(255) DEFAULT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (mobile_brands_id)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS mobile_brands"

  end

end
