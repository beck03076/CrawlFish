class CreateSponsoredSellerCityListings < ActiveRecord::Migration

  def up

  execute "DROP TABLE IF EXISTS sponsored_seller_city_listings"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS sponsored_seller_city_listings (
  city_listings_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (city_listings_id),
  UNIQUE (vendor_id,city_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  SQL

  end

  def down
  execute "DROP TABLE IF EXISTS sponsored_seller_city_listings"
  end

end
