class CreateMousesLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS mouses_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS mouses_lists (
		mouses_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		mouse_name VARCHAR(255) NOT NULL,
	  	mouse_part_no VARCHAR(255) NOT NULL,
		mouse_image_url TEXT DEFAULT NULL,
		mouse_brand VARCHAR(255) NOT NULL,
		mouse_color VARCHAR(255) NOT NULL,
		mouse_features TEXT NOT NULL,
		mouse_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (mouses_list_id),
		UNIQUE(mouse_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE mouses_lists"

  end

end
