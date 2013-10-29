class CreateProcedureGatewayCallsTabletsLists < ActiveRecord::Migration

   def up

    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_tablets_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_tablets_lists(IN v3_product_id BIGINT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255))

    BEGIN

    DECLARE v_product_features TEXT;

    DECLARE v_tablet_name,v_tablet_feature_name VARCHAR(255);

    DECLARE v_sub_category_id INT;

    DECLARE v_tablets_list_id,v_tablet_feature_id BIGINT;

    DECLARE done INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring (v3_sub_category);



    /* ###########################========= tablet name ===============############*/

    /* selecting the tablet name from the part2 db in order to
    insert into the filters collections   */

    SELECT tablets_list_id,tablet_name INTO v_tablets_list_id,v_tablet_name
    FROM tablets_lists
    WHERE tablet_name  = v3_product_name
    LIMIT 1;

    IF v_tablet_name IS NOT NULL AND v_tablets_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_tablet_name,
                                       v_tablets_list_id,
                                       "tablets_lists",
                                       "tablet_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('tablet name ',v_tablet_name,
    ' is not inserted into products_filters'));

     END IF;

    /* ###########################========= tablet name end ===============############*/

    /* ###########################========= tablet features ===============############*/
    /* selecting the tablet features from the part2 db in order to
    insert into the filters collections   */

    SELECT feature_id  INTO v_tablet_feature_id
    FROM link_f1_tablets_lists
    WHERE tablets_list_id = v3_product_id;

    IF v_tablet_feature_id IS NOT NULL THEN

    SELECT feature_name INTO v_tablet_feature_name
    FROM tablets_f1_features
    WHERE feature_id  = v_tablet_feature_id;

    call p_Insert_filters_collections( NULL, v_tablet_feature_name,
                                       v_tablet_feature_id,
                                       "LinkF1TabletsLists",
                                       "feature_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a feature_name into filters ',v_tablet_feature_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the feature_name ',v_tablet_feature_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= tablet feature end ===============############*/

  END;

  SQL

  end


  def down

    execute "DROP PROCEDURE p_gateway_calls_tablets_lists"

  end

end
