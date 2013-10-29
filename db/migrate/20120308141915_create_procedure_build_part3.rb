class CreateProcedureBuildPart3 < ActiveRecord::Migration
  def up
    execute "DROP PROCEDURE IF EXISTS p_build_part3"

    execute <<-SQL
    CREATE PROCEDURE p_build_part3(IN v2_product_sub_category VARCHAR(255),
				   IN v2_vendor_id INT,
                                   IN v2_products_list_id BIGINT,
                                   IN v2_availability_id INT,
                                   IN v2_debug_id VARCHAR(255),
				   IN v2_delete_flag INT)
    BEGIN


    DECLARE v_Count INT;


    IF v2_delete_flag = 0 THEN

    IF v2_product_sub_category = "books_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f10_vendor_books_lists
     WHERE vendor_id = v2_vendor_id AND books_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f10_vendor_books_lists(  vendor_id,
                                        books_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and books_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f10_vendor_books_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND books_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and books_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "mobiles_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f16_vendor_mobiles_lists
     WHERE vendor_id = v2_vendor_id AND mobiles_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f16_vendor_mobiles_lists(  vendor_id,
                                        mobiles_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and mobiles_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f16_vendor_mobiles_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND mobiles_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and mobiles_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "laptops_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_laptops_lists
     WHERE vendor_id = v2_vendor_id AND laptops_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_laptops_lists(vendor_id,
                                        laptops_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and laptops_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f2_vendor_laptops_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND laptops_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and laptops_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

    IF v2_product_sub_category = "desktops_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_desktops_lists
     WHERE vendor_id = v2_vendor_id AND desktops_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_desktops_lists(vendor_id,
                                        desktops_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and desktops_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN

     UPDATE link_f2_vendor_desktops_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND desktops_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and desktops_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

    
    IF v2_product_sub_category = "external_hdds_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_external_hdds_lists
     WHERE vendor_id = v2_vendor_id AND external_hdds_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_external_hdds_lists(vendor_id,
                                        external_hdds_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and external_hdds_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_external_hdds_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND external_hdds_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and external_hdds_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


   IF v2_product_sub_category = "printers_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_printers_lists
     WHERE vendor_id = v2_vendor_id AND printers_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_printers_lists(vendor_id,
                                        printers_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and printers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_printers_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND printers_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and printers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;



   IF v2_product_sub_category = "routers_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_routers_lists
     WHERE vendor_id = v2_vendor_id AND routers_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_routers_lists(vendor_id,
                                        routers_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and routers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_routers_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND routers_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and routers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

   IF v2_product_sub_category = "mouses_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_mouses_lists
     WHERE vendor_id = v2_vendor_id AND mouses_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_mouses_lists(vendor_id,
                                        mouses_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and mouses_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_mouses_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND mouses_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and mouses_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "keyboards_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_keyboards_lists
     WHERE vendor_id = v2_vendor_id AND keyboards_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_keyboards_lists(vendor_id,
                                        keyboards_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and keyboards_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_keyboards_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND keyboards_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and keyboards_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

    
    IF v2_product_sub_category = "speakers_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_speakers_lists
     WHERE vendor_id = v2_vendor_id AND speakers_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_speakers_lists(vendor_id,
                                        speakers_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and speakers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_speakers_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND speakers_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and speakers_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

  
   IF v2_product_sub_category = "memory_cards_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_memory_cards_lists
     WHERE vendor_id = v2_vendor_id AND memory_cards_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_memory_cards_lists(vendor_id,
                                        memory_cards_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and memory_cards_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_memory_cards_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND memory_cards_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and memory_cards_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "pendrives_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_pendrives_lists
     WHERE vendor_id = v2_vendor_id AND pendrives_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_pendrives_lists(vendor_id,
                                        pendrives_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and pendrives_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_pendrives_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND pendrives_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and pendrives_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "headphones_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_headphones_lists
     WHERE vendor_id = v2_vendor_id AND headphones_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_headphones_lists(vendor_id,
                                        headphones_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and headphones_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_headphones_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND headphones_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and headphones_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;

   IF v2_product_sub_category = "headsets_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_headsets_lists
     WHERE vendor_id = v2_vendor_id AND headsets_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_headsets_lists(vendor_id,
                                        headsets_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and headsets_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_headsets_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND headsets_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and headsets_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    IF v2_product_sub_category = "tablets_lists" THEN

     SELECT COUNT(*) INTO v_Count
     FROM link_f2_vendor_tablets_lists
     WHERE vendor_id = v2_vendor_id AND tablets_list_id = v2_products_list_id;

     IF v_Count = 0 THEN

     INSERT INTO link_f2_vendor_tablets_lists(vendor_id,
                                        tablets_list_id,
                                        availability_id,
                                        created_at)
     values(v2_vendor_id,
            v2_products_list_id,
            v2_availability_id,
            CURRENT_TIMESTAMP);

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Insert Scenario - A link for the availability_id ',v2_availability_id,' and tablets_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is created, about a nanosecond ago'));

     ELSEIF v_Count <> 0 THEN


     UPDATE link_f2_vendor_tablets_lists SET availability_id = v2_availability_id
     WHERE vendor_id = v2_vendor_id AND tablets_list_id = v2_products_list_id;

      /* Insert a record in debug table for tracking the events */
      call debug.debug_insert(v2_debug_id,concat('Update scenario - A link for the availability_id ',v2_availability_id,' and tablets_list_id ',v2_products_list_id,' and vendor_id ',v2_vendor_id,
      ' is Update, about a nanosecond ago'));


     END IF;

    END IF;


    END IF;

     END;

    SQL
  end

  def down

    execute "DROP PROCEDURE p_build_part3"

  end
end

