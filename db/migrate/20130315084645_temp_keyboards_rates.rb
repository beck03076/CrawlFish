class TempKeyboardsRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_keyboards_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_keyboards_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  keyboard_part_no VARCHAR(255) NOT NULL,
  keyboard_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_keyboards_rates AFTER INSERT ON temp_keyboards_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_keyboards_rates";
    DECLARE v_keyboards_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT keyboards_list_id INTO v_keyboards_list_id FROM keyboards_lists
    WHERE f_stripstring(keyboard_part_no)=f_stripstring(new.keyboard_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("keyboards_list_id found is ",v_keyboards_list_id));

    IF v_keyboards_list_id IS NOT NULL THEN

    INSERT INTO keyboards_rates (keyboards_list_id, keyboard_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_keyboards_list_id, new.keyboard_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into keyboards_rates table for keyboards_list_id, ",v_keyboards_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_keyboards_rates"
    execute "DROP TRIGGER IF EXISTS t_i_keyboards_rates"
  end

end
