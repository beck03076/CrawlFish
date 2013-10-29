class CreatePrintersLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS printers_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS printers_lists (
		printers_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		printer_name VARCHAR(255) NOT NULL,
	  	printer_model_name VARCHAR(255) NOT NULL,
		printer_image_url TEXT DEFAULT NULL,
		printer_brand VARCHAR(255) NOT NULL,
		printer_type VARCHAR(255) NOT NULL,
		printer_features TEXT NOT NULL,
		printer_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (printers_list_id),
		UNIQUE(printer_model_name)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE printers_lists"

  end

end
