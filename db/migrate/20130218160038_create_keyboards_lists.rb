class CreateKeyboardsLists < ActiveRecord::Migration

 def up
 	
	execute "DROP TABLE IF EXISTS keyboards_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS keyboards_lists (
		keyboards_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		keyboard_name VARCHAR(255) NOT NULL,
	  	keyboard_part_no VARCHAR(255) NOT NULL,
		keyboard_image_url TEXT DEFAULT NULL,
		keyboard_brand VARCHAR(255) NOT NULL,
		keyboard_interface VARCHAR(255) NOT NULL,
		keyboard_features TEXT NOT NULL,
		keyboard_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (keyboards_list_id),
		UNIQUE(keyboard_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE keyboards_lists"

  end

end
