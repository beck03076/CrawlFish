class CreateLinkF1PrintersLists < ActiveRecord::Migration

   def up

	execute "DROP TABLE IF EXISTS link_f1_printers_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f1_printers_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		printers_list_id BIGINT UNSIGNED NOT NULL,
		feature_id BIGINT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (printers_list_id,feature_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  	SQL

  end

  def down

	execute "DROP TABLE link_f1_printers_lists"

  end

end
