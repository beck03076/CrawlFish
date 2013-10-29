class CreatePendrivesLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS pendrives_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS pendrives_lists (
		pendrives_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		pendrive_name VARCHAR(255) NOT NULL,
	  	pendrive_part_no VARCHAR(255) NOT NULL,
		pendrive_image_url TEXT DEFAULT NULL,
		pendrive_brand VARCHAR(255) NOT NULL,
		pendrive_type VARCHAR(255) NOT NULL,
		pendrive_features TEXT NOT NULL,
		pendrive_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (pendrives_list_id),
		UNIQUE(pendrive_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE pendrives_lists"

  end

end
