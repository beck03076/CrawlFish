class TempDesktopsRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_desktops_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_desktops_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  desktop_part_no VARCHAR(255) NOT NULL,
  desktop_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_desktops_rates AFTER INSERT ON temp_desktops_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_desktops_rates";
    DECLARE v_desktops_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT desktops_list_id INTO v_desktops_list_id FROM desktops_lists
    WHERE f_stripstring(desktop_part_no)=f_stripstring(new.desktop_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("desktops_list_id found is ",v_desktops_list_id));

    IF v_desktops_list_id IS NOT NULL THEN

    INSERT INTO desktops_rates (desktops_list_id, desktop_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_desktops_list_id, new.desktop_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into desktops_rates table for desktops_list_id, ",v_desktops_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_desktops_rates"
    execute "DROP TRIGGER IF EXISTS t_i_desktops_rates"
  end

end
