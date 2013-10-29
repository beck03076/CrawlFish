class TempHeadphonesRates < ActiveRecord::Migration
  
 def up

  execute "DROP TABLE IF EXISTS temp_headphones_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_headphones_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  headphone_part_no VARCHAR(255) NOT NULL,
  headphone_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_headphones_rates AFTER INSERT ON temp_headphones_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_headphones_rates";
    DECLARE v_headphones_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT headphones_list_id INTO v_headphones_list_id FROM headphones_lists
    WHERE f_stripstring(headphone_part_no)=f_stripstring(new.headphone_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("headphones_list_id found is ",v_headphones_list_id));

    IF v_headphones_list_id IS NOT NULL THEN

    INSERT INTO headphones_rates (headphones_list_id, headphone_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_headphones_list_id, new.headphone_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into headphones_rates table for headphones_list_id, ",v_headphones_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_headphones_rates"
    execute "DROP TRIGGER IF EXISTS t_i_headphones_rates"
  end


end
