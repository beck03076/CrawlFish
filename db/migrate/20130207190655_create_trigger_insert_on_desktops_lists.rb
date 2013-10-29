class CreateTriggerInsertOnDesktopsLists < ActiveRecord::Migration
  
  def up

    execute "DROP TRIGGER IF EXISTS t_Insert_Desktops_Lists"
    execute "DROP TRIGGER IF EXISTS t_Update_Desktops_Lists"
    execute "DROP TRIGGER IF EXISTS t_Delete_Desktops_Lists"


    execute <<-SQL
    CREATE TRIGGER t_Insert_Desktops_Lists AFTER INSERT ON desktops_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_feature_id BIGINT;

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_I_L_',new.desktops_list_id,'_',new.desktop_name);
  
    call p_Insert_desktops_f1_features(new.desktop_features,v_DebugID,v_feature_id);

    call p_Insert_link_f1_desktops_lists(new.desktops_list_id,v_feature_id,v_DebugID);
 
    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,'Calling the procedure to check priority error table');

    call p_Check_priority_table("desktops_lists",new.desktop_name,new.desktop_brand,new.desktop_part_no);

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL
    CREATE TRIGGER t_Update_Desktops_Lists AFTER UPDATE ON desktops_lists
    FOR EACH ROW
    BEGIN

    DECLARE v_feature_id BIGINT;

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_U_L_',new.desktops_list_id,'_',new.desktop_name);


    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

   
    /* call the following procedures to update/ignore a desktop feature from desktops_lists table into index tables based */
    /* on its non-existence/existence respectively */


    call p_Insert_desktops_f1_features(new.desktop_features,v_DebugID,v_feature_id);

    call p_Insert_link_f1_desktops_lists(new.desktops_list_id,v_feature_id,v_DebugID);
 
    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Delete_Desktops_Lists BEFORE DELETE ON desktops_lists
    FOR EACH ROW
    BEGIN

   
    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID TEXT DEFAULT concat('t_D_L_',old.desktops_list_id,'_',old.desktop_name);

    SET FOREIGN_KEY_CHECKS = 0;

    /*After declaring v_DebugID, the debug_on procedure is called which inserts a record in debug table */
    call debug.debug_on(v_DebugID);

	   
    call p_Delete_link_f1_desktops_lists(old.desktops_list_id,v_DebugID);


    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    SET FOREIGN_KEY_CHECKS = 1;

    END;

    SQL




  end

  def down

    execute "DROP TRIGGER t_Insert_Desktops_Lists"
    execute "DROP TRIGGER t_Update_Desktops_Lists"
    execute "DROP TRIGGER t_Delete_Desktops_Lists"

  end

end
