class CreateAdListDetails < ActiveRecord::Migration
  def up

  execute <<-SQL

  CREATE TABLE ad_list_details (
      ad_list_details_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
      vendor_id INT UNSIGNED NOT NULL,
      product_id BIGINT UNSIGNED NOT NULL,
      sub_category_id INT UNSIGNED NOT NULL,
      ad_text TEXT NOT NULL,
      ad_banner_image TEXT NULL,
      ad_external_url TEXT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      active_flag CHAR(1) DEFAULT "n",
      PRIMARY KEY (ad_list_details_id),  
      UNIQUE (vendor_id,ad_list_details_id)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS ad_list_details"

  end
end

