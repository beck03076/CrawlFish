class CreateTriggerOnMobilesRates < ActiveRecord::Migration
  def up
    
    execute "DROP TRIGGER IF EXISTS t_Update_mobiles_rates"

    execute <<-SQL
    CREATE TRIGGER t_Update_mobiles_rates AFTER UPDATE ON mobiles_rates
    FOR EACH ROW
    BEGIN

    /* Declare the debug id to log every event under this id inside debug.debug table */
    DECLARE v_DebugID varchar(255) DEFAULT 't_Update_mobiles_rates';
    DECLARE v_mobile_name, v_mobile_brand, v_mobile_color VARCHAR(255);

    /*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
    call debug.debug_on(v_DebugID);
    
    SELECT mobile_name, mobile_brand, mobile_color INTO v_mobile_name, v_mobile_brand, v_mobile_color FROM mobiles_lists
    WHERE mobiles_list_id = new.mobiles_list_id;

    /* Insert a record in debug table for tracking the events */
    call debug.debug_insert(v_DebugID,concat('Updating the DP rate of mobile ',v_mobile_name,',',v_mobile_color,' for the local vendors'));

    
    UPDATE local_chennai_velachery_csmworld_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_besantnagar_mmrcommunication_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_adyar_vinodcellworld_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_besantnagar_vinodcellworld_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    
    IF v_mobile_brand = "nokia" THEN
    
    UPDATE local_chennai_velachery_jaisaimobiles_products SET product_price = (new.dp_tamilnadu + 100)
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_vadapalani_bbcelectronics_products SET product_price = (new.dp_tamilnadu + 100)
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_tnagar_queenszone_products SET product_price = (new.dp_tamilnadu + (new.dp_tamilnadu * 0.03))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;    

    UPDATE local_chennai_sholinganallur_landmarkscommn_products SET product_price = (new.dp_tamilnadu + 25)
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    ELSE
    
    UPDATE local_chennai_velachery_jaisaimobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_vadapalani_bbcelectronics_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_tnagar_queenszone_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;    
    
     UPDATE local_chennai_sholinganallur_landmarkscommn_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    END IF;    
    

    UPDATE local_chennai_adyar_citymobilecare_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_adyar_romustelecom_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_rapuram_romustelecom_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_alwarpet_gkmobilepark_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_tnagar_matrix_products SET product_price = (new.dp_tamilnadu + (0.02 * new.dp_tamilnadu))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_alwarpet_simcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_neelankarai_simcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_velachery_simcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_alwarpet_studiocell_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_tnagar_studiocell_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_kodambakkam_cellking_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;


    IF v_mobile_brand = "micromax" OR v_mobile_brand = "lava" OR v_mobile_brand = "karbonn" THEN

    UPDATE local_chennai_tnagar_likemobiles_products SET product_price = (new.dp_tamilnadu + (new.dp_tamilnadu * 0.03))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    ELSE
    
    UPDATE local_chennai_tnagar_likemobiles_products SET product_price = (new.dp_tamilnadu + (new.dp_tamilnadu * 0.01))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    END IF;
    
    
    UPDATE local_chennai_tnagar_milkywaycelltech_products SET product_price = (new.dp_tamilnadu + (new.dp_tamilnadu * 0.02))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_thousandlights_mobileparadise_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_tnagar_pujas_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
   
    UPDATE local_chennai_mylapore_smartcell_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_saligramam_thanujamobileworld_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_thiruvanmiyur_adyarnethuts_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_kilpauk_cellzone_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    
    IF v_mobile_brand = "samsung" THEN
    
    UPDATE local_chennai_kilpauk_chennaicellpoint_products SET product_price = (new.dp_tamilnadu + 100)
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    ELSE
     
    UPDATE local_chennai_kilpauk_chennaicellpoint_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    END IF;
    
    
    UPDATE local_chennai_purasawakkam_easycellcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_egmore_pritamcommunications_products SET product_price = (new.dp_tamilnadu + (new.dp_tamilnadu * 0.01))
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_choolaimedu_rosemobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_perambur_rosemobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_adambakkam_rosemobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_kilkattalai_rosemobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_kilpauk_samsungplazasrees_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_thousandlights_twentymobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_tambaram_stmobiles_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;
    
    UPDATE local_chennai_chrompet_anandacellcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_selaiyur_anandacellcity_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_thuraipakkam_samsungsmartphone_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_porur_sonycenter_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    UPDATE local_chennai_porur_skytel_products SET product_price = new.dp_tamilnadu
    WHERE product_name = v_mobile_name AND product_identifier1 = v_mobile_brand AND product_identifier2 = v_mobile_color;

    /* Ending the debug table insert with a #(pound) mark */
    call debug.debug_off(v_DebugID);

    END
    SQL
  end

  def down
        execute "DROP TRIGGER t_Update_mobiles_rates"
  end
end
