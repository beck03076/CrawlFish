class CreateLinkF1TabletsLists < ActiveRecord::Migration

   def up

	execute "DROP TABLE IF EXISTS link_f1_tablets_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f1_tablets_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		tablets_list_id BIGINT UNSIGNED NOT NULL,
		feature_id BIGINT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (tablets_list_id,feature_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  	SQL

  end

  def down

	execute "DROP TABLE link_f1_tablets_lists"

  end

end
