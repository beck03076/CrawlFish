class CreateExternalHddsLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS external_hdds_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS external_hdds_lists (
		external_hdds_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		external_hdd_name VARCHAR(255) NOT NULL,
	  	external_hdd_part_no VARCHAR(255) NOT NULL,
		external_hdd_image_url TEXT DEFAULT NULL,
		external_hdd_brand VARCHAR(255) NOT NULL,
		external_hdd_color VARCHAR(255) NOT NULL,
		external_hdd_features TEXT NOT NULL,
		external_hdd_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (external_hdds_list_id),
		UNIQUE(external_hdd_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE external_hdds_lists"

  end

end
