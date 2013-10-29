class CreateTempSearchkeyLogs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS temp_searchkey_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_searchkey_logs (
  log_id INT UNSIGNED AUTO_INCREMENT,
  search_keys VARCHAR(500) NOT NULL,
  landing_page VARCHAR(255) NOT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE temp_searchkey_logs"
  end
end

