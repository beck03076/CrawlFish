class CreateMemoryCardsLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS memory_cards_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS memory_cards_lists (
		memory_cards_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		memory_card_name VARCHAR(255) NOT NULL,
	  	memory_card_part_no VARCHAR(255) NOT NULL,
		memory_card_image_url TEXT DEFAULT NULL,
		memory_card_brand VARCHAR(255) NOT NULL,
		memory_card_type VARCHAR(255) NOT NULL,
		memory_card_features TEXT NOT NULL,
		memory_card_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (memory_cards_list_id),
		UNIQUE(memory_card_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE memory_cards_lists"

  end

end
