`class CreateTriggerOnVendorCoupons < ActiveRecord::Migration
  def up

    execute "DROP TRIGGER IF EXISTS t_insert_vendor_coupons"

    execute <<-SQL
    CREATE TRIGGER t_insert_vendor_coupons AFTER INSERT ON vendor_coupons
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_insert_vendor_coupons';
    DECLARE v_sub_category_name, v_product_name,v_product_identifier2,v_vendor_phone_number,v_customer_phone_number, v_vendor_name, v_vendor_city, v_vendor_branch VARCHAR(255);
    DECLARE v_sub_category_id INT; 
    DECLARE v_products_list_id BIGINT;


    /*After declaring v_DebugID, the debug_on procedure is called which will insert a record in debug table */
    call debug.debug_on(v_DebugID);

    SELECT products_list_id INTO v_products_list_id FROM link_products_lists_vendors
    WHERE unique_id = new.unique_id AND sub_category_id = new.sub_category_id;

    SELECT sub_category_name INTO v_sub_category_name FROM subcategories
    WHERE sub_category_id = new.sub_category_id;

    IF v_sub_category_name = "books_lists" THEN

	SELECT book_name, isbn13 INTO v_product_name, v_product_identifier2 FROM books_lists WHERE books_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "mobiles_lists" THEN

	SELECT mobile_name, mobile_color INTO v_product_name, v_product_identifier2 FROM mobiles_lists WHERE mobiles_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "laptops_lists" THEN

	SELECT laptop_name, laptop_part_no INTO v_product_name, v_product_identifier2 FROM laptops_lists WHERE laptops_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "desktops_lists" THEN

	SELECT desktop_name, desktop_part_no INTO v_product_name, v_product_identifier2 FROM desktops_lists WHERE desktops_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "external_hdds_lists" THEN

	SELECT external_hdd_name, external_hdd_part_no INTO v_product_name, v_product_identifier2 FROM external_hdds_lists WHERE external_hdds_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "printers_lists" THEN

	SELECT printer_name, printer_model_name INTO v_product_name, v_product_identifier2 FROM printers_lists WHERE printers_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "routers_lists" THEN

	SELECT router_name, router_part_no INTO v_product_name, v_product_identifier2 FROM routers_lists WHERE routers_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "mouses_lists" THEN

	SELECT mouse_name, mouse_part_no INTO v_product_name, v_product_identifier2 FROM mouses_lists WHERE mouses_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "keyboards_lists" THEN

	SELECT keyboard_name, keyboard_part_no INTO v_product_name, v_product_identifier2 FROM keyboards_lists WHERE keyboards_list_id = v_products_list_id;
 
    ELSEIF v_sub_category_name = "speakers_lists" THEN

	SELECT speaker_name, speaker_part_no INTO v_product_name, v_product_identifier2 FROM speakers_lists WHERE speakers_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "memory_cards_lists" THEN

	SELECT memory_card_name, memory_card_part_no INTO v_product_name, v_product_identifier2 FROM memory_cards_lists WHERE memory_cards_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "pendrives_lists" THEN

	SELECT pendrive_name, pendrive_part_no INTO v_product_name, v_product_identifier2 FROM pendrives_lists WHERE pendrives_list_id = v_products_list_id;
    
    ELSEIF v_sub_category_name = "headphones_lists" THEN

	SELECT headphone_name, headphone_part_no INTO v_product_name, v_product_identifier2 FROM headphones_lists WHERE headphones_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "headsets_lists" THEN

	SELECT headset_name, headset_part_no INTO v_product_name, v_product_identifier2 FROM headsets_lists WHERE headsets_list_id = v_products_list_id;

    ELSEIF v_sub_category_name = "tablets_lists" THEN

	SELECT tablet_name, tablet_part_no INTO v_product_name, v_product_identifier2 FROM tablets_lists WHERE tablets_list_id = v_products_list_id;


    END IF;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Product details found");


    SELECT vendor_name, vendor_city, vendor_branch,vendor_phone INTO v_vendor_name, v_vendor_city, v_vendor_branch,v_vendor_phone_number FROM vendors_details
    WHERE vendor_id = new.vendor_id;

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,"Vendor details found");



    INSERT INTO vendor_coupons_details (coupon_id, coupon_code, sub_category_name, product_name, product_identifier2, vendor_name, vendor_branch_name, vendor_city_name,vendor_phone_number,customer_phone_number,created_at)
    VALUES (new.coupon_id, new.coupon_code, v_sub_category_name, v_product_name,v_product_identifier2, v_vendor_name, v_vendor_branch, v_vendor_city,v_vendor_phone_number,new.customer_phone_number, CURRENT_TIMESTAMP);

    /* Inserting a record into debug table */
    call debug.debug_insert(v_DebugID,concat("Inserted a record into vendor_coupons_details table for unique_id, ",new.unique_id));

    

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL

  end

  def down
    execute "DROP TRIGGER t_insert_vendor_coupons"
  end
end
