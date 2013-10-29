class CreateAdListDetailsCounts < ActiveRecord::Migration
  def up

  execute <<-SQL

      CREATE TABLE ad_list_details_counts (
      id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
      ad_list_details_id BIGINT UNSIGNED NOT NULL,
      displayed_page VARCHAR(255) NOT NULL,
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (id)  
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS ad_list_details_counts"

  end
end

