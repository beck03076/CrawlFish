class Nearby6kms < ActiveRecord::Migration
  def up
  
        execute <<-SQL
            CREATE TABLE IF NOT EXISTS temp_nearby_6kms_branches (
            id INT UNSIGNED NOT NULL AUTO_INCREMENT,
            city_name VARCHAR(255) NOT NULL,
            branch_name VARCHAR(255) NOT NULL,
            area VARCHAR(255) NOT NULL,
            created_at DATETIME NOT NULL,
            updated_at DATETIME DEFAULT NULL,
            PRIMARY KEY (id)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
        SQL
        execute <<-SQL
            CREATE TABLE IF NOT EXISTS nearby_6kms_branches (
            id INT UNSIGNED NOT NULL AUTO_INCREMENT,
            city_id INT(10) UNSIGNED NOT NULL,
            branch_id INT(10) UNSIGNED NOT NULL,
            area_id INT(10) UNSIGNED NOT NULL,
            created_at DATETIME NOT NULL,
            updated_at DATETIME DEFAULT NULL,
            PRIMARY KEY (id)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
        SQL
        execute <<-SQL
            CREATE TRIGGER t_area_6kms AFTER INSERT ON temp_nearby_6kms_branches

            FOR EACH ROW 
            BEGIN

            DECLARE v_city_id INT(10);
            DECLARE v_branch_id INT(10);
            DECLARE v_area_id INT(10);

            SELECT city_id INTO v_city_id from cities WHERE city_name=NEW.city_name;
            SELECT branch_id INTO v_branch_id from branches WHERE branch_name=NEW.branch_name;
            SELECT branch_id INTO v_area_id from branches WHERE branch_name=NEW.area;

            INSERT INTO nearby_6kms_branches (city_id,branch_id,area_id,created_at) VALUES (v_city_id,v_branch_id,v_area_id,CURRENT_TIMESTAMP);

            END;
    
        SQL
    
  end

  def down
    
      execute "DROP TABLE temp_nearby_6kms_branches"
      
      execute "DROP TABLE nearby_6kms_branches;"
      
      execute "DROP TRIGGER t_area_6kms"
      
      execute "DROP TABLE temp_nearby_6kms_branches"
  
  end
end
