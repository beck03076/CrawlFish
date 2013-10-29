class CreateFeaturesMasterValues < ActiveRecord::Migration
  def up

  execute <<-SQL

  CREATE TABLE features_master_values (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
      feature_name VARCHAR(255) NOT NULL,
      active_flag CHAR(1) DEFAULT "n",
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (id)  
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS features_master_values"

  end

end
