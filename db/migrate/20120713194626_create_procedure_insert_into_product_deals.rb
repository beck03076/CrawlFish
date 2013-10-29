class CreateProcedureInsertIntoProductDeals < ActiveRecord::Migration
  def up

  
    execute <<-SQL
    CREATE PROCEDURE p_Insert_into_product_deals (IN v1_type VARCHAR(255),
						  IN v1_sub_category VARCHAR(255),
	                                          IN v1_product_name VARCHAR(255),
						  IN v1_identifier1 VARCHAR(255),
						  IN v1_identifier2 VARCHAR(255),
						  IN v1_business_type VARCHAR(255),
						  IN v1_vendor_id INT,
						  IN v1_deal_info TEXT,
						  IN v1_DebugId VARCHAR(255))
    BEGIN

	DECLARE v_sub_category_id, v_product_id, v_unique_id INT;

	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,concat("Subcategory value is ",v1_sub_category));

	IF v1_sub_category = "books" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given book deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "books_lists";

	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT books_list_id INTO v_product_id FROM books_lists
		WHERE f_stripstring(book_name) = f_stripstring(v1_product_name) AND f_stripstring(isbn13) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "mobiles" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given mobile deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "mobiles_lists";

		SELECT MAX(unique_id), products_list_id INTO v_unique_id, v_product_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id IN 
		(SELECT mobiles_list_id FROM mobiles_lists WHERE f_stripstring(mobile_name) = f_stripstring(v1_product_name)
		AND f_stripstring(mobile_brand) = f_stripstring(v1_identifier1)) AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "laptops" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given laptop deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "laptops_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT laptops_list_id INTO v_product_id FROM laptops_lists
		WHERE f_stripstring(laptop_name) = f_stripstring(v1_product_name) AND f_stripstring(laptop_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

        IF v1_sub_category = "desktops" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given desktop deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "desktops_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT desktops_list_id INTO v_product_id FROM desktops_lists
		WHERE f_stripstring(desktop_name) = f_stripstring(v1_product_name) AND f_stripstring(desktop_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "external_hdds" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given external_hdd deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "external_hdds_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT external_hdds_list_id INTO v_product_id FROM external_hdds_lists
		WHERE f_stripstring(external_hdd_name) = f_stripstring(v1_product_name) AND f_stripstring(external_hdd_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


        IF v1_sub_category = "printers" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given printers deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "printers_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT printers_list_id INTO v_product_id FROM printers_lists
		WHERE f_stripstring(printer_name) = f_stripstring(v1_product_name) AND f_stripstring(printer_model_name) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


        IF v1_sub_category = "routers" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given router deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "routers_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT routers_list_id INTO v_product_id FROM routers_lists
		WHERE f_stripstring(router_name) = f_stripstring(v1_product_name) AND f_stripstring(router_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

 	
	IF v1_sub_category = "mouses" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given mouses deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "mouses_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT mouses_list_id INTO v_product_id FROM mouses_lists
		WHERE f_stripstring(mouse_name) = f_stripstring(v1_product_name) AND f_stripstring(mouse_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


	IF v1_sub_category = "keyboards" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given keyboard deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "keyboards_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT keyboards_list_id INTO v_product_id FROM keyboards_lists
		WHERE f_stripstring(keyboard_name) = f_stripstring(v1_product_name) AND f_stripstring(keyboard_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "speakers" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given speaker deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "speakers_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT speakers_list_id INTO v_product_id FROM speakers_lists
		WHERE f_stripstring(speaker_name) = f_stripstring(v1_product_name) AND f_stripstring(speaker_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

	IF v1_sub_category = "memory_cards" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given memory card deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "memory_cards_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT memory_cards_list_id INTO v_product_id FROM memory_cards_lists
		WHERE f_stripstring(memory_card_name) = f_stripstring(v1_product_name) AND f_stripstring(memory_card_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


	IF v1_sub_category = "pendrives" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given pendrive deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "pendrives_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT pendrives_list_id INTO v_product_id FROM pendrives_lists
		WHERE f_stripstring(pendrive_name) = f_stripstring(v1_product_name) AND f_stripstring(pendrive_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;

        IF v1_sub_category = "headphones" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given headphone deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "headphones_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT headphones_list_id INTO v_product_id FROM headphones_lists
		WHERE f_stripstring(headphone_name) = f_stripstring(v1_product_name) AND f_stripstring(headphone_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


        IF v1_sub_category = "headsets" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given headset deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "headsets_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT headsets_list_id INTO v_product_id FROM headsets_lists
		WHERE f_stripstring(headset_name) = f_stripstring(v1_product_name) AND f_stripstring(headset_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


        IF v1_sub_category = "tablets" THEN
		
	    /* Inserting a record into debug table */
	    call debug.debug_insert(v1_DebugID,"Finding all the details for the given tablet deal");

		SELECT sub_category_id INTO v_sub_category_id FROM subcategories
		WHERE sub_category_name = "tablets_lists";

	    	/* Inserting a record into debug table */
	    	call debug.debug_insert(v1_DebugID,concat("subcategory id is ",v_sub_category_id));

		SELECT tablets_list_id INTO v_product_id FROM tablets_lists
		WHERE f_stripstring(tablet_name) = f_stripstring(v1_product_name) AND f_stripstring(tablet_part_no) = f_stripstring(v1_identifier2);

		SELECT unique_id INTO v_unique_id FROM link_products_lists_vendors
		WHERE vendor_id = v1_vendor_id AND products_list_id = v_product_id AND sub_category_id = v_sub_category_id;

	END IF;


	IF v1_type = "insert" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Inserting a record into product_deals table");

	INSERT INTO product_deals(vendor_id, sub_category_id, product_id, business_type, unique_id, deal_info, created_at)
	VALUES(v1_vendor_id, v_sub_category_id, v_product_id, v1_business_type, v_unique_id, v1_deal_info,CURRENT_TIMESTAMP);

	ELSEIF v1_type = "update" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Updating a record in product_deals table");

	UPDATE product_deals SET vendor_id = v1_vendor_id, sub_category_id = v_sub_category_id, product_id = v_product_id,
	unique_id = v_unique_id, deal_info = v1_deal_info, updated_at = CURRENT_TIMESTAMP WHERE business_type = v1_business_type;

	ELSEIF v1_type = "delete" THEN

        /* Inserting a record into debug table */
	call debug.debug_insert(v1_DebugID,"Deleting a record from product_deals table");

	DELETE FROM product_deals WHERE vendor_id = v1_vendor_id;

	END IF;

    END
    SQL
  end

  def down
  	execute "DROP PROCEDURE p_Insert_into_product_deals"
  end
end
