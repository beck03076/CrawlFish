class CreateProcedureGatewayCallsLaptopsLists < ActiveRecord::Migration

  def up

    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_laptops_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_laptops_lists(IN v3_product_id BIGINT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255))

    BEGIN

    DECLARE v_product_features TEXT;

    DECLARE v_laptop_name,v_laptop_feature_name VARCHAR(255);

    DECLARE v_sub_category_id INT;

    DECLARE v_laptops_list_id,v_laptop_feature_id BIGINT;

    DECLARE done INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring (v3_sub_category);



    /* ###########################========= laptop name ===============############*/

    /* selecting the laptop name from the part2 db in order to
    insert into the filters collections   */

    SELECT laptops_list_id,laptop_name INTO v_laptops_list_id,v_laptop_name
    FROM laptops_lists
    WHERE laptop_name  = v3_product_name
    LIMIT 1;

    IF v_laptop_name IS NOT NULL AND v_laptops_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_laptop_name,
                                       v_laptops_list_id,
                                       "laptops_lists",
                                       "laptop_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('laptop name ',v_laptop_name,
    ' is not inserted into products_filters'));

     END IF;

    /* ###########################========= laptop name end ===============############*/

    /* ###########################========= laptop features ===============############*/
    /* selecting the laptop features from the part2 db in order to
    insert into the filters collections   */

    SELECT feature_id  INTO v_laptop_feature_id
    FROM link_f1_laptops_lists
    WHERE laptops_list_id = v3_product_id;

    IF v_laptop_feature_id IS NOT NULL THEN

    SELECT feature_name INTO v_laptop_feature_name
    FROM laptops_f1_features
    WHERE feature_id  = v_laptop_feature_id;

    call p_Insert_filters_collections( NULL, v_laptop_feature_name,
                                       v_laptop_feature_id,
                                       "LinkF1LaptopsLists",
                                       "feature_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a feature_name into filters ',v_laptop_feature_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the feature_name ',v_laptop_feature_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= laptop feature end ===============############*/

  END;

  SQL

  end


  def down

    execute "DROP PROCEDURE p_gateway_calls_laptops_lists"

  end


end
