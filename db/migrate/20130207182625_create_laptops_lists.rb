class CreateLaptopsLists < ActiveRecord::Migration
  
  def up
 	
	execute "DROP TABLE IF EXISTS laptops_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS laptops_lists (
		laptops_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		laptop_name VARCHAR(255) NOT NULL,
	  	laptop_part_no VARCHAR(255) NOT NULL,
		laptop_image_url TEXT DEFAULT NULL,
		laptop_brand VARCHAR(255) NOT NULL,
		laptop_color VARCHAR(255) NOT NULL,
		laptop_features TEXT NOT NULL,
		laptop_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (laptops_list_id),
		UNIQUE(laptop_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE laptops_lists"

  end

end
