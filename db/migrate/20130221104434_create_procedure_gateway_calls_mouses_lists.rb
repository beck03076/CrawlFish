class CreateProcedureGatewayCallsMousesLists < ActiveRecord::Migration

  def up

    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_mouses_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_mouses_lists(IN v3_product_id BIGINT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255))
    BEGIN

    DECLARE v_product_features TEXT;

    DECLARE v_mouse_name,v_mouse_feature_name VARCHAR(255);

    DECLARE v_sub_category_id INT;

    DECLARE v_mouses_list_id,v_mouse_feature_id BIGINT;

    DECLARE done INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring (v3_sub_category);



    /* ###########################========= mouse name ===============############*/

    /* selecting the mouse name from the part2 db in order to
    insert into the filters collections   */

    SELECT mouses_list_id,mouse_name INTO v_mouses_list_id,v_mouse_name
    FROM mouses_lists
    WHERE mouse_name  = v3_product_name
    LIMIT 1;

    IF v_mouse_name IS NOT NULL AND v_mouses_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_mouse_name,
                                       v_mouses_list_id,
                                       "mouses_lists",
                                       "mouse_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('mouse name ',v_mouse_name,
    ' is not inserted into products_filters'));

     END IF;

    /* ###########################========= mouse name end ===============############*/

    /* ###########################========= mouse features ===============############*/
    /* selecting the mouse features from the part2 db in order to
    insert into the filters collections   */

    SELECT feature_id  INTO v_mouse_feature_id
    FROM link_f1_mouses_lists
    WHERE mouses_list_id = v3_product_id;

    IF v_mouse_feature_id IS NOT NULL THEN

    SELECT feature_name INTO v_mouse_feature_name
    FROM mouses_f1_features
    WHERE feature_id  = v_mouse_feature_id;

    call p_Insert_filters_collections( NULL, v_mouse_feature_name,
                                       v_mouse_feature_id,
                                       "LinkF1MousesLists",
                                       "feature_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a feature_name into filters ',v_mouse_feature_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the feature_name ',v_mouse_feature_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= mouse feature end ===============############*/

  END;

  SQL

  end


  def down

    execute "DROP PROCEDURE p_gateway_calls_mouses_lists"

  end

end
