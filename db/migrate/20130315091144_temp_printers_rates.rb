class TempPrintersRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_printers_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_printers_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  printer_model_name VARCHAR(255) NOT NULL,
  printer_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_printers_rates AFTER INSERT ON temp_printers_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_printers_rates";
    DECLARE v_printers_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT printers_list_id INTO v_printers_list_id FROM printers_lists
    WHERE f_stripstring(printer_model_name)=f_stripstring(new.printer_model_name);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("printers_list_id found is ",v_printers_list_id));

    IF v_printers_list_id IS NOT NULL THEN

    INSERT INTO printers_rates (printers_list_id, printer_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_printers_list_id, new.printer_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into printers_rates table for printers_list_id, ",v_printers_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_printers_rates"
    execute "DROP TRIGGER IF EXISTS t_i_printers_rates"
  end

end
