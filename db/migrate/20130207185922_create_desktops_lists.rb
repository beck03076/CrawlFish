class CreateDesktopsLists < ActiveRecord::Migration
  
  def up
 	
	execute "DROP TABLE IF EXISTS desktops_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS desktops_lists (
		desktops_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		desktop_name VARCHAR(255) NOT NULL,
	  	desktop_part_no VARCHAR(255) NOT NULL,
		desktop_image_url TEXT DEFAULT NULL,
		desktop_brand VARCHAR(255) NOT NULL,
		desktop_color VARCHAR(255) NOT NULL,
		desktop_features TEXT NOT NULL,
		desktop_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (desktops_list_id),
		UNIQUE(desktop_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE desktops_lists"

  end

end
