class TempMemoryCardsRates < ActiveRecord::Migration

 def up

  execute "DROP TABLE IF EXISTS temp_memory_cards_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_memory_cards_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  memory_card_part_no VARCHAR(255) NOT NULL,
  memory_card_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_memory_cards_rates AFTER INSERT ON temp_memory_cards_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_memory_cards_rates";
    DECLARE v_memory_cards_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT memory_cards_list_id INTO v_memory_cards_list_id FROM memory_cards_lists
    WHERE f_stripstring(memory_card_part_no)=f_stripstring(new.memory_card_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("memory_cards_list_id found is ",v_memory_cards_list_id));

    IF v_memory_cards_list_id IS NOT NULL THEN

    INSERT INTO memory_cards_rates (memory_cards_list_id, memory_card_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_memory_cards_list_id, new.memory_card_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into memory_cards_rates table for memory_cards_list_id, ",v_memory_cards_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_memory_cards_rates"
    execute "DROP TRIGGER IF EXISTS t_i_memory_cards_rates"
  end

end
