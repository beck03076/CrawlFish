class CreateProcedureInsertIntoKeyboardsIndexTables < ActiveRecord::Migration

   def up
 
     execute <<-SQL
     CREATE PROCEDURE p_Insert_keyboards_f1_features(IN v1_keyboard_feature_name TEXT, IN v1_debugid VARCHAR(255),
                                          OUT v1_feature_id BIGINT)
     BEGIN

     DECLARE v_COUNT,v_CountFilters INT;

     SELECT COUNT(*) INTO v_COUNT
     FROM keyboards_f1_features
     WHERE feature_name= v1_keyboard_feature_name;

     IF v_COUNT = 0 THEN

     	INSERT INTO keyboards_f1_features(feature_name,
                                created_at)
     	values(v1_keyboard_feature_name,
            CURRENT_TIMESTAMP);

      	/* Insert a record in debug table for tracking the events */
      	call debug.debug_insert(v1_debugid,'A feature name is inserted into keyboards_f1_features');

     ELSE

      	/* Insert a record in debug table for tracking the events */
     	call debug.debug_insert(v1_debugid,'The feature name already exists so, the insert is aborted');

     END IF;

     SELECT feature_id
     INTO v1_feature_id
     FROM keyboards_f1_features
     WHERE feature_name = v1_keyboard_feature_name;

    END;

   SQL

  end


  def down

	execute "DROP PROCEDURE p_Insert_keyboards_f1_features"

  end

end
