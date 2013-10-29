class CreateSponsoredSellerAreaListings < ActiveRecord::Migration

  def up

  execute "DROP TABLE IF EXISTS sponsored_seller_area_listings"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS sponsored_seller_area_listings (
  area_listings_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city_id INT UNSIGNED NOT NULL,
  branch_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  mobile_brands_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (area_listings_id),
  UNIQUE (vendor_id,branch_id,mobile_brands_id,city_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL

  end

  def down
  execute "DROP TABLE IF EXISTS sponsored_seller_area_listings"
  end

end
