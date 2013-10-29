class TempMobilesRates < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS temp_mobiles_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_mobiles_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  mobile_name VARCHAR(255) NOT NULL,
  mobile_brand VARCHAR(255) NOT NULL,
  mobile_color VARCHAR(255) NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_mobile_rates AFTER INSERT ON temp_mobiles_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_mobile_rates";
    DECLARE v_mobiles_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT mobiles_list_id INTO v_mobiles_list_id FROM mobiles_lists
    WHERE f_stripstring(mobile_name)=f_stripstring(new.mobile_name) AND f_stripstring(mobile_brand)=f_stripstring(new.mobile_brand) AND 
    f_stripstring(mobile_color)=f_stripstring(new.mobile_color);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("mobiles_list_id found is ",v_mobiles_list_id));

    IF v_mobiles_list_id IS NOT NULL THEN

    INSERT INTO mobiles_rates (mobiles_list_id, mrp, dp_tamilnadu, created_at)
    VALUES (v_mobiles_list_id, new.mrp, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into mobiles_rates table for mobiles_list_id, ",v_mobiles_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_mobiles_rates"
    execute "DROP TRIGGER IF EXISTS t_i_mobile_rates"
  end
end
