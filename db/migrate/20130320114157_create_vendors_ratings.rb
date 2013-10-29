class CreateVendorsRatings < ActiveRecord::Migration

 def up
    execute "DROP TABLE IF EXISTS vendors_ratings"

    execute <<-SQL
    CREATE TABLE vendors_ratings (
      rating_id BIGINT UNSIGNED AUTO_INCREMENT,
      vendor_id  BIGINT NOT NULL,
      ratings int(1) DEFAULT NULL,
      reviews TEXT DEFAULT NULL,
      customer_id BIGINT NOT NULL,
      created_at DATETIME NOT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (rating_id)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    SQL

 end

 def down
    execute "DROP TABLE vendors_ratings"
 end

end
