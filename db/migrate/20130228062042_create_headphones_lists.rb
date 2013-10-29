class CreateHeadphonesLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS headphones_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS headphones_lists (
		headphones_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		headphone_name VARCHAR(255) NOT NULL,
	  	headphone_part_no VARCHAR(255) NOT NULL,
		headphone_image_url TEXT DEFAULT NULL,
		headphone_brand VARCHAR(255) NOT NULL,
		headphone_type VARCHAR(255) NOT NULL,
		headphone_features TEXT NOT NULL,
		headphone_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (headphones_list_id),
		UNIQUE(headphone_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE headphones_lists"

  end

end
