class CreateLinkF2VendorPrintersLists < ActiveRecord::Migration

  def up

	execute "DROP TABLE IF EXISTS link_f2_vendor_printers_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f2_vendor_printers_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		vendor_id INT UNSIGNED NOT NULL,
		printers_list_id BIGINT UNSIGNED NOT NULL,
		availability_id INT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (vendor_id,printers_list_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
	SQL

  end

  def down

	execute "DROP TABLE link_f2_vendor_printers_lists"

  end

end
