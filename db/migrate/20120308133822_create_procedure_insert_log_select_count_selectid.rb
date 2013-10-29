class CreateProcedureInsertLogSelectCountSelectid < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Insertlog_selectcount_selectid"

    execute <<-SQL


   CREATE PROCEDURE p_Insertlog_selectcount_selectid(IN v1_configured_by VARCHAR(255),
                                                      IN v1_reason VARCHAR(255),
                                                      IN v1_validity VARCHAR(255),
                  IN v1_product_sub_category VARCHAR(255),
                  IN v1_product_name VARCHAR(255),
                                                      IN v1_product_id BIGINT,
                                                      IN v1_vendorID INT,
                                                      OUT v1_countproductslists INT,
                                                      OUT v1_products_list_id BIGINT,
                                                      IN v1_product_identifier1 VARCHAR(255),
                                                      IN v1_product_identifier2 VARCHAR(255),
                                                      IN v1_debugid VARCHAR(255))
     BEGIN


    /* Finding the sub_category id */

    DECLARE v_sub_category_id INT;

    SELECT sub_category_id INTO v_sub_category_id FROM subcategories
    WHERE f_stripstring(sub_category_name) = f_stripstring(v1_product_sub_category);

    /* Insert a log into vendors_config_logs table for every insert in online_flipkart_products table */
    INSERT
    INTO vendors_config_logs(configured_by,
                                    reason,
                                    validity,
                                    product_id,
                                    vendor_id,
            sub_category_id,
                                    created_at)
    VALUES( v1_configured_by,
            v1_reason,
            v1_validity,
            v1_product_id,
            v1_vendorID,
      v_sub_category_id,
            now());

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,'A record is inserted into the vendors_config_logs about a nanosecond ago');

   IF LOWER(v1_product_sub_category) = "books_lists" THEN

  /* ####### Books Lists #######  */

     /* select the count of books in books_lists using isbn, isbn13 and book_name from books_lists */
    /* and product_name and   product_features in online_flipkart_products table  */
    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM books_lists
    WHERE f_stripstring(isbn13) = f_stripstring(v1_product_identifier2);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Books_lists for ',v1_product_identifier1,
    ' and found ',v1_countproductslists,' book(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT books_list_id
    INTO v1_products_list_id
    FROM books_lists
    WHERE f_stripstring(isbn13) = f_stripstring(v1_product_identifier2);

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the idetifiers ',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "mobiles_lists" THEN

  /* ####### Mobiles Lists #######  */

     /* select the count of mobiles in mobiles_lists using mobile name, mobile brand and mobile color from mobiles_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM mobiles_lists
    WHERE f_stripstring(mobile_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Mobiles_lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' mobile(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT mobiles_list_id
    INTO v1_products_list_id
    FROM mobiles_lists
    WHERE f_stripstring(mobile_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the idetifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "laptops_lists" THEN

  /* ####### Laptops Lists #######  */

     /* select the count of laptops in laptops_lists using laptop part no from laptops_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM laptops_lists
    WHERE f_stripstring(laptop_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Laptops_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' laptop(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT laptops_list_id
    INTO v1_products_list_id
    FROM laptops_lists
    WHERE f_stripstring(laptop_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


   IF LOWER(v1_product_sub_category) = "desktops_lists" THEN

  /* ####### desktops Lists #######  */

     /* select the count of desktops in desktops_lists using desktop part no from desktop_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM desktops_lists
    WHERE f_stripstring(desktop_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in Desktops_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' desktop(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT desktops_list_id
    INTO v1_products_list_id
    FROM desktops_lists
    WHERE f_stripstring(desktop_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "external_hdds_lists" THEN

  /* ####### External Hdds Lists #######  */

     /* select the count of External Hdds in external_hdds_lists using external_hdd part no from external_hdds_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM external_hdds_lists
    WHERE f_stripstring(external_hdd_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in External_Hdds_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' external hdd(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT external_hdds_list_id
    INTO v1_products_list_id
    FROM external_hdds_lists
    WHERE f_stripstring(external_hdd_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "printers_lists" THEN

  /* ####### Printers Lists #######  */

     /* select the count of Printers in printers_lists using printers model name from printers_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM printers_lists
    WHERE f_stripstring(printer_name) = f_stripstring(v1_product_name)
    LIMIT 1;    

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in printers_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' printer(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT printers_list_id
    INTO v1_products_list_id
    FROM printers_lists
    WHERE f_stripstring(printer_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "routers_lists" THEN

  /* ####### Routers Lists #######  */

     /* select the count of Routers in routers_lists using routers part no from routers_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM routers_lists
    WHERE f_stripstring(router_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in routers_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' router(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT routers_list_id
    INTO v1_products_list_id
    FROM routers_lists
    WHERE f_stripstring(router_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "mouses_lists" THEN

  /* ####### mouses Lists #######  */

     /* select the count of Mouse in mouses_lists using mouse part no from mouses_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM mouses_lists
    WHERE f_stripstring(mouse_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in mouses_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' mouse(mouses), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT mouses_list_id
    INTO v1_products_list_id
    FROM mouses_lists
    WHERE f_stripstring(mouse_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;



    IF LOWER(v1_product_sub_category) = "keyboards_lists" THEN

  /* ####### Keyboards Lists #######  */

     /* select the count of keyboard in keyboards_lists using keyboard part no from keyboards_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM keyboards_lists
    WHERE f_stripstring(keyboard_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in keyboards_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' keyboard(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT keyboards_list_id
    INTO v1_products_list_id
    FROM keyboards_lists
    WHERE f_stripstring(keyboard_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "speakers_lists" THEN

  /* ####### speakers Lists #######  */

     /* select the count of speaker in speakers_lists using speaker part no from speakers_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM speakers_lists
    WHERE f_stripstring(speaker_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in speakers_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' speaker(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT speakers_list_id
    INTO v1_products_list_id
    FROM speakers_lists
    WHERE f_stripstring(speaker_name) = f_stripstring(v1_product_name)
    LIMIT 1;
        

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "memory_cards_lists" THEN

  /* ####### memory_cards Lists #######  */

     /* select the count of memory_card in memory_cards_lists using memory_card part no from memory_cards_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM memory_cards_lists
    WHERE f_stripstring(memory_card_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in memory_cards_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' memory_card(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT memory_cards_list_id
    INTO v1_products_list_id
    FROM memory_cards_lists
    WHERE f_stripstring(memory_card_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


   IF LOWER(v1_product_sub_category) = "pendrives_lists" THEN

  /* ####### pendrives Lists #######  */

     /* select the count of pendrive in pendrives_lists using pendrive part no from pendrives_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM pendrives_lists
    WHERE f_stripstring(pendrive_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in pendrives_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' pendrive(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT pendrives_list_id
    INTO v1_products_list_id
    FROM pendrives_lists
    WHERE f_stripstring(pendrive_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "headphones_lists" THEN

  /* ####### headphones Lists #######  */

     /* select the count of headphone in headphones_lists using headphone part no from headphones_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM headphones_lists
    WHERE f_stripstring(headphone_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in headphones_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' headphone(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT headphones_list_id
    INTO v1_products_list_id
    FROM headphones_lists
    WHERE f_stripstring(headphone_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


    IF LOWER(v1_product_sub_category) = "headsets_lists" THEN

  /* ####### headsets Lists #######  */

     /* select the count of headset in headsets_lists using headset part no from headsets_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM headsets_lists
    WHERE f_stripstring(headset_name) = f_stripstring(v1_product_name)
    LIMIT 1;
    
    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in headsets_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' headset(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT headsets_list_id
    INTO v1_products_list_id
    FROM headsets_lists
    WHERE f_stripstring(headset_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;

    
    IF LOWER(v1_product_sub_category) = "tablets_lists" THEN

  /* ####### tablets Lists #######  */

     /* select the count of tablet in tablets_lists using tablet part no from tablets_lists */

    SELECT COUNT(*)
    INTO v1_countproductslists
    FROM tablets_lists
    WHERE f_stripstring(tablet_name) = f_stripstring(v1_product_name)
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Counting Records in tablets_Lists for ',v1_product_name,
    ' and found ',v1_countproductslists,' tablet(s), about a nanosecond ago'));

    IF v1_countproductslists <> 0 THEN


    SELECT tablets_list_id
    INTO v1_products_list_id
    FROM tablets_lists
    WHERE f_stripstring(tablet_name) = f_stripstring(v1_product_name) 
    LIMIT 1;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v1_debugid,concat('Selected product id from part-2 db for the identifiers ',v1_product_name,',',v1_product_identifier1,' and ',v1_product_identifier2,' about a nanosecond ago'));

    ELSE

    SET v1_products_list_id = 0;

    END IF;

    END IF;


     END;

     SQL

  end

  def down

    execute "DROP PROCEDURE p_Insertlog_selectcount_selectid"

  end
end

