class CreateSpeakersF1Features < ActiveRecord::Migration

 def up
 	
	execute "DROP TABLE IF EXISTS speakers_f1_features"
	execute <<-SQL
    	CREATE TABLE IF NOT EXISTS speakers_f1_features (
		feature_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
		feature_name TEXT NOT NULL,
		created_at DATETIME NOT NULL,
		updated_at DATETIME DEFAULT NULL,
		PRIMARY KEY (feature_id)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    	SQL
  end

  def down

	execute "DROP TABLE speakers_f1_features"

  end

end
