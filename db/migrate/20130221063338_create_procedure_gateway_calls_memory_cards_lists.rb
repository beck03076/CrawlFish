class CreateProcedureGatewayCallsMemoryCardsLists < ActiveRecord::Migration
  
  def up

    execute "DROP PROCEDURE IF EXISTS p_gateway_calls_memory_cards_lists"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_calls_memory_cards_lists(IN v3_product_id BIGINT,
                                            IN v3_sub_category VARCHAR(255),
                                            IN v3_debug_id VARCHAR(255),
					    IN v3_product_name VARCHAR(255))

    BEGIN

    DECLARE v_product_features TEXT;

    DECLARE v_memory_card_name,v_memory_card_feature_name VARCHAR(255);

    DECLARE v_sub_category_id INT;

    DECLARE v_memory_cards_list_id,v_memory_card_feature_id BIGINT;

    DECLARE done INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    SELECT sub_category_id INTO v_sub_category_id
    FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring (v3_sub_category);



    /* ###########################========= memory_card name ===============############*/

    /* selecting the memory_card name from the part2 db in order to
    insert into the filters collections   */

    SELECT memory_cards_list_id,memory_card_name INTO v_memory_cards_list_id,v_memory_card_name
    FROM memory_cards_lists
    WHERE memory_card_name  = v3_product_name
    LIMIT 1;

    IF v_memory_card_name IS NOT NULL AND v_memory_cards_list_id IS NOT NULL THEN

    call p_Insert_filters_collections( "products_name",
				       v_memory_card_name,
                                       v_memory_cards_list_id,
                                       "memory_cards_lists",
                                       "memory_card_name",
                                       v_sub_category_id,
                                       v3_debug_id);



     ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('memory_card name ',v_memory_card_name,
    ' is not inserted into products_filters'));

     END IF;

    /* ###########################========= memory_card name end ===============############*/

    /* ###########################========= memory_card features ===============############*/
    /* selecting the memory_card features from the part2 db in order to
    insert into the filters collections   */

    SELECT feature_id  INTO v_memory_card_feature_id
    FROM link_f1_memory_cards_lists
    WHERE memory_cards_list_id = v3_product_id;

    IF v_memory_card_feature_id IS NOT NULL THEN

    SELECT feature_name INTO v_memory_card_feature_name
    FROM memory_cards_f1_features
    WHERE feature_id  = v_memory_card_feature_id;

    call p_Insert_filters_collections( NULL, v_memory_card_feature_name,
                                       v_memory_card_feature_id,
                                       "LinkF1MemoryCardsLists",
                                       "feature_id",
                                       v_sub_category_id,
                                       v3_debug_id);

   /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Inserted a feature_name into filters ',v_memory_card_feature_name,
    ' about a  nanosecond ago'));

    ELSE

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v3_debug_id,concat('Not inserted the feature_name ',v_memory_card_feature_name,
    ' about a  nanosecond ago'));

    END IF;

   /* ###########################========= memory_card feature end ===============############*/

  END;

  SQL

  end


  def down

    execute "DROP PROCEDURE p_gateway_calls_memory_cards_lists"

  end

end
