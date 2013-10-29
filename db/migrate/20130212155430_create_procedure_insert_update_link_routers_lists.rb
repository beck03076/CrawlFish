class CreateProcedureInsertUpdateLinkRoutersLists < ActiveRecord::Migration
  
  def up

    execute <<-SQL
    CREATE PROCEDURE p_Insert_link_f1_routers_lists(IN v1_routers_list_id BIGINT,
                                                  IN v1_feature_id BIGINT,
                                                  IN v1_debugid VARCHAR(255))
     BEGIN

     DECLARE v_COUNT INT;

     IF v1_feature_id = 0 THEN
   	 /* Insert a record in debug table for tracking the events */
   	  call debug.debug_insert(v1_debugid,'No record is inserted into link_f1_routers_lists');

     	DELETE FROM link_f1_routers_lists
     	WHERE routers_list_id = v1_routers_list_id;

     ELSE

     	SELECT COUNT(*) INTO v_COUNT FROM link_f1_routers_lists
     	WHERE routers_list_id = v1_routers_list_id;

     IF v_COUNT > 0 THEN

     	UPDATE link_f1_routers_lists 
     	SET feature_id = v1_feature_id
     	WHERE routers_list_id = v1_routers_list_id;

      	/* Insert a record in debug table for tracking the events */
      	call debug.debug_insert(v1_debugid,'Already existing link has been updated in link_f1_routers_lists');


     ELSE

     	INSERT INTO link_f1_routers_lists(routers_list_id,
                                     feature_id,
                                     created_at)
     	values(v1_routers_list_id,
            v1_feature_id,
            CURRENT_TIMESTAMP);

     	 /* Insert a record in debug table for tracking the events */
     	 call debug.debug_insert(v1_debugid,concat('A link for the feature_id ',v1_feature_id,' and routers_list_id ',v1_routers_list_id,
     	 ' is created, about a nanosecond ago'));

     END IF;

    END IF;

    END;

    SQL


  end


  def down

	execute "DROP PROCEDURE p_Insert_link_f1_routers_lists"

  end

end
