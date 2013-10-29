class CreateLinkF1MemoryCardsLists < ActiveRecord::Migration

  def up

	execute "DROP TABLE IF EXISTS link_f1_memory_cards_lists"
	execute <<-SQL
	CREATE TABLE IF NOT EXISTS link_f1_memory_cards_lists (
		id INT UNSIGNED NOT NULL AUTO_INCREMENT,
		memory_cards_list_id BIGINT UNSIGNED NOT NULL,
		feature_id BIGINT UNSIGNED NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (id),
		UNIQUE (memory_cards_list_id,feature_id)
	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  	SQL

  end

  def down

	execute "DROP TABLE link_f1_memory_cards_lists"

  end

end
