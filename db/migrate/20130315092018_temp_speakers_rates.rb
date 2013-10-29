class TempSpeakersRates < ActiveRecord::Migration

  def up

  execute "DROP TABLE IF EXISTS temp_speakers_rates"

  execute <<-SQL
  CREATE TABLE IF NOT EXISTS temp_speakers_rates (
  id INT UNSIGNED AUTO_INCREMENT,
  speaker_part_no VARCHAR(255) NOT NULL,
  speaker_price_source_url TEXT NOT NULL,
  dp_tamilnadu DOUBLE,
  mrp DOUBLE DEFAULT 0,
  created_at DATETIME,
  PRIMARY KEY (id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
  SQL

    execute <<-SQL
    CREATE TRIGGER t_i_speakers_rates AFTER INSERT ON temp_speakers_rates
    FOR EACH ROW
    BEGIN

    DECLARE v_DebugID varchar(255) DEFAULT "t_i_speakers_rates";
    DECLARE v_speakers_list_id BIGINT;


    call debug.debug_on(v_DebugID);

    SELECT speakers_list_id INTO v_speakers_list_id FROM speakers_lists
    WHERE f_stripstring(speaker_part_no)=f_stripstring(new.speaker_part_no);


    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("speakers_list_id found is ",v_speakers_list_id));

    IF v_speakers_list_id IS NOT NULL THEN

    INSERT INTO speakers_rates (speakers_list_id, speaker_price_source_url, dp_tamilnadu, created_at)
    VALUES (v_speakers_list_id, new.speaker_price_source_url, new.dp_tamilnadu, CURRENT_TIMESTAMP);

    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into speakers_rates table for speakers_list_id, ",v_speakers_list_id));


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS temp_speakers_rates"
    execute "DROP TRIGGER IF EXISTS t_i_speakers_rates"
  end

end
