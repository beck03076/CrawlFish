class CreateLinkF2VendorLaptopsLists < ActiveRecord::Migration
   
  def up

	execute "DROP TABLE IF EXISTS link_f2_vendor_laptops_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f2_vendor_laptops_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		vendor_id INT UNSIGNED NOT NULL,
		laptops_list_id BIGINT UNSIGNED NOT NULL,
		availability_id INT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (vendor_id,laptops_list_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
	SQL

  end

  def down

	execute "DROP TABLE link_f2_vendor_laptops_lists"

  end

end
