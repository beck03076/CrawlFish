class CreateTabletsLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS tablets_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS tablets_lists (
		tablets_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		tablet_name VARCHAR(255) NOT NULL,
	  	tablet_part_no VARCHAR(255) NOT NULL,
		tablet_image_url TEXT DEFAULT NULL,
		tablet_brand VARCHAR(255) NOT NULL,
		tablet_color VARCHAR(255) NOT NULL,
		tablet_features TEXT NOT NULL,
		tablet_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (tablets_list_id),
		UNIQUE(tablet_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE tablets_lists"

  end

end
