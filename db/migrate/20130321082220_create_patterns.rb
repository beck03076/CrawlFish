class CreatePatterns < ActiveRecord::Migration
def up
    execute "DROP TABLE IF EXISTS patterns"

    execute <<-SQL
    CREATE TABLE patterns (
      id INT(11) UNSIGNED AUTO_INCREMENT,
      vendor_id INT(11) NOT NULL,
      pattern TEXT NOT NULL,
      t_name VARCHAR(255) NOT NULL,
      b_type VARCHAR(10) NOT NULL,
      u_at DATETIME NOT NULL,
      PRIMARY KEY (id)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    SQL

 end
  def down
    execute "DROP TABLE patterns"
  end
end
