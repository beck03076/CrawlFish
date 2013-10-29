class CreateProcedureSelectAvailabilityIdAndCount < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Select_availability_id_and_count"

    execute <<-SQL
    CREATE PROCEDURE p_Select_availability_id_and_count(IN v2_product_sub_category VARCHAR(255),
					      IN v2_product_availability VARCHAR(255),
                                              OUT v1_availability_count INT,
					      OUT v1_availability_id INT)
    BEGIN

    IF v2_product_sub_category = "books_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM books_vendor_f10_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "mobiles_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM mobiles_vendor_f16_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "laptops_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM laptops_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "desktops_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM desktops_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;


    IF v2_product_sub_category = "external_hdds_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM external_hdds_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "printers_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM printers_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "routers_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM routers_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "mouses_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM mouses_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    IF v2_product_sub_category = "keyboards_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM keyboards_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;


    IF v2_product_sub_category = "speakers_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM speakers_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    
    IF v2_product_sub_category = "memory_cards_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM memory_cards_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;


    IF v2_product_sub_category = "pendrives_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM pendrives_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;


    IF v2_product_sub_category = "headphones_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM headphones_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;


    IF v2_product_sub_category = "headsets_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM headsets_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

    
    IF v2_product_sub_category = "tablets_lists" THEN
	
    SELECT COUNT(*),availability_id INTO v1_availability_count,v1_availability_id
    FROM tablets_vendor_f2_availabilities
    WHERE f_stripstring(availability) = f_stripstring(v2_product_availability);

    END IF;

  END;

  SQL

  end

  def down

   execute "DROP PROCEDURE p_Select_availability_id_and_count"

  end
end
