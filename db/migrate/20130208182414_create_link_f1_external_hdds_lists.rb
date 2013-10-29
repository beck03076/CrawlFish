class CreateLinkF1ExternalHddsLists < ActiveRecord::Migration
   
  def up

	execute "DROP TABLE IF EXISTS link_f1_external_hdds_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f1_external_hdds_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		external_hdds_list_id BIGINT UNSIGNED NOT NULL,
		feature_id BIGINT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (external_hdds_list_id,feature_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  	SQL

  end

  def down

	execute "DROP TABLE link_f1_external_hdds_lists"

  end

end
