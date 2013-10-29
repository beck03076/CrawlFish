class TempPendrivesRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_pendrives_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_pendrives_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  pendrive_part_no VARCHAR(255) NOT NULL,
  pendrive_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_pendrives_rates AFTER INSERT ON temp_pendrives_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_pendrives_rates";
    DECLARE v_pendrives_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT pendrives_list_id INTO v_pendrives_list_id FROM pendrives_lists
    WHERE f_stripstring(pendrive_part_no)=f_stripstring(new.pendrive_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("pendrives_list_id found is ",v_pendrives_list_id));

    IF v_pendrives_list_id IS NOT NULL THEN

    INSERT INTO pendrives_rates (pendrives_list_id, pendrive_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_pendrives_list_id, new.pendrive_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into pendrives_rates table for pendrives_list_id, ",v_pendrives_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_pendrives_rates"
    execute "DROP TRIGGER IF EXISTS t_i_pendrives_rates"
  end

end
