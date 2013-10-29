class CreateAndGoLoginDetails < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS and_go_login_details"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS and_go_login_details (
  and_go_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  login_name VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  password_salt VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (and_go_id),
  UNIQUE (login_name)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS and_go_login_details"
  end
end

