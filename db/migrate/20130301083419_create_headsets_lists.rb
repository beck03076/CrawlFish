class CreateHeadsetsLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS headsets_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS headsets_lists (
		headsets_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		headset_name VARCHAR(255) NOT NULL,
	  	headset_part_no VARCHAR(255) NOT NULL,
		headset_image_url TEXT DEFAULT NULL,
		headset_brand VARCHAR(255) NOT NULL,
		headset_type VARCHAR(255) NOT NULL,
		headset_features TEXT NOT NULL,
		headset_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (headsets_list_id),
		UNIQUE(headset_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE headsets_lists"

  end

end
