class TempTabletsRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_tablets_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_tablets_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  tablet_part_no VARCHAR(255) NOT NULL,
  tablet_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_tablets_rates AFTER INSERT ON temp_tablets_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_tablets_rates";
    DECLARE v_tablets_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT tablets_list_id INTO v_tablets_list_id FROM tablets_lists
    WHERE f_stripstring(tablet_part_no)=f_stripstring(new.tablet_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("tablets_list_id found is ",v_tablets_list_id));

    IF v_tablets_list_id IS NOT NULL THEN

    INSERT INTO tablets_rates (tablets_list_id, tablet_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_tablets_list_id, new.tablet_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into tablets_rates table for tablets_list_id, ",v_tablets_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_tablets_rates"
    execute "DROP TRIGGER IF EXISTS t_i_tablets_rates"
  end

end
