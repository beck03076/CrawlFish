class CreateTriggerInsertOnTabletsLists < ActiveRecord::Migration

  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Tablets_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Tablets_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Tablets_Lists"


    execute <<-SQL
    CREATE TRIGGER t_Insert_Tablets_Lists AFTER INSERT ON tablets_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_feature_id BIGINT;

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_I_L_',new.tablets_list_id,'_',new.tablet_name);
  
    call p_Insert_tablets_f1_features(new.tablet_features,v_DebugID,v_feature_id);

    call p_Insert_link_f1_tablets_lists(new.tablets_list_id,v_feature_id,v_DebugID);
 
    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure to check priority error table');

    call p_Check_priority_table("tablets_lists",new.tablet_name,new.tablet_brand,new.tablet_part_no);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Tablets_Lists AFTER UPDATE ON tablets_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_feature_id BIGINT;

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_U_L_',new.tablets_list_id,'_',new.tablet_name);


    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

   
    /* call the following procedures to update/ignore a tablet feature from tablets_lists table into index tables based */
    /* on its non-existence/existence respectively */


    call p_Insert_tablets_f1_features(new.tablet_features,v_DebugID,v_feature_id);

    call p_Insert_link_f1_tablets_lists(new.tablets_list_id,v_feature_id,v_DebugID);
 
    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Delete_Tablets_Lists BEFORE DELETE ON tablets_lists
    FOR EACH ROW
    BEGIN

   
    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_D_L_',old.tablets_list_id,'_',old.tablet_name);

    SET FOREIGN_KEY_CHECKS = 0;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	   
    call p_Delete_link_f1_tablets_lists(old.tablets_list_id,v_DebugID);


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    SET FOREIGN_KEY_CHECKS = 1;

    END;

    SQL




  end

  def down

    execute "DROP TRIGGER t_Insert_Tablets_Lists"
    execute "DROP TRIGGER t_Update_Tablets_Lists"
    execute "DROP TRIGGER t_Delete_Tablets_Lists"

  end

end
