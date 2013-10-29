class CreateRoutersRates < ActiveRecord::Migration

  def up

  execute "DROP TABLE IF EXISTS routers_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS routers_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  routers_list_id BIGINT UNSIGNED NOT NULL,
  router_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
 	
	 execute "DROP TABLE routers_rates"

  end

end
