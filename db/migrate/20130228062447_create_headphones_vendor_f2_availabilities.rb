class CreateHeadphonesVendorF2Availabilities < ActiveRecord::Migration

   def up

	execute "DROP TABLE IF EXISTS headphones_vendor_f2_availabilities"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS headphones_vendor_f2_availabilities (
		availability_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		availability VARCHAR(255) NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (availability_id),
		UNIQUE (availability)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
	SQL
  end

  def down

	execute "DROP TABLE headphones_vendor_f2_availabilities"

  end

end
