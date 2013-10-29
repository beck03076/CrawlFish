class CreateMobilesLists < ActiveRecord::Migration
def up
    execute "DROP TABLE IF EXISTS mobiles_lists"
    
    execute <<-SQL
    CREATE TABLE mobiles_lists (
      mobiles_list_id BIGINT UNSIGNED AUTO_INCREMENT,
      mobile_name VARCHAR(255) NOT NULL,
      mobile_image_url TEXT DEFAULT NULL,
      mobile_features TEXT NOT NULL,
      mobile_brand VARCHAR(255) NOT NULL,
      mobile_color VARCHAR(255) NOT NULL,
      mobile_availability_flag CHAR(1) DEFAULT "y",
      created_at DATETIME NOT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (mobiles_list_id),
      UNIQUE(mobile_name,mobile_color)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    SQL

    end
  def down
    execute "DROP TABLE mobiles_lists"
  end
end

