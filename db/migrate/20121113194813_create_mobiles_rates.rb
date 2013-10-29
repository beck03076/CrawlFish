class CreateMobilesRates < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS mobiles_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS mobiles_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  mobiles_list_id BIGINT UNSIGNED NOT NULL,
  mrp DOUBLE,
  dp_tamilnadu DOUBLE,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE mobiles_rates"
  end
end
