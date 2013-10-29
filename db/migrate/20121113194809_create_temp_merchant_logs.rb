class CreateTempMerchantLogs < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS temp_merchant_logs"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_merchant_logs (
  log_id INT UNSIGNED AUTO_INCREMENT,
  merchant_id INT UNSIGNED NOT NULL,
  vendor_id INT UNSIGNED NOT NULL,
  login_name VARCHAR(255) NOT NULL,
  login_time DATETIME NOT NULL,
  logout_time DATETIME NOT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (log_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE temp_merchant_logs"
  end
end

