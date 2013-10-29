class CreateSpeakersLists < ActiveRecord::Migration

  def up
 	
	execute "DROP TABLE IF EXISTS speakers_lists"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS speakers_lists (
		speakers_list_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		speaker_name VARCHAR(255) NOT NULL,
	  	speaker_part_no VARCHAR(255) NOT NULL,
		speaker_image_url TEXT DEFAULT NULL,
		speaker_brand VARCHAR(255) NOT NULL,
		speaker_type VARCHAR(255) NOT NULL,
		speaker_features TEXT NOT NULL,
		speaker_availability_flag CHAR(1) DEFAULT "y" NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (speakers_list_id),
		UNIQUE(speaker_part_no)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE speakers_lists"

  end

end
