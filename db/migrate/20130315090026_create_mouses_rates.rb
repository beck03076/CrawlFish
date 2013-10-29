class CreateMousesRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS mouses_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mouses_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  mouses_list_id BIGINT UNSIGNED NOT NULL,
  mouse_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
 	
	 execute "DROP TABLE mouses_rates"

  end

end
