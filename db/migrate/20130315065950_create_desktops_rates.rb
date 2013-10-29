class CreateDesktopsRates < ActiveRecord::Migration

  def up

  execute "DROP TABLE IF EXISTS desktops_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS desktops_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  desktops_list_id BIGINT UNSIGNED NOT NULL,
  desktop_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
 	
	 execute "DROP TABLE desktops_rates"

  end

end
