class CreateRoutersLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS routers_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS routers_lists (
		routers_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		router_name VARCHAR(255) NOT NULL,
	  	router_part_no VARCHAR(255) NOT NULL,
		router_image_url TEXT DEFAULT NULL,
		router_brand VARCHAR(255) NOT NULL,
		router_type VARCHAR(255) NOT NULL,
		router_features TEXT NOT NULL,
		router_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (routers_list_id),
		UNIQUE(router_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE routers_lists"

  end

end
