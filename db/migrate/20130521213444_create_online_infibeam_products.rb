class CreateOnlineInfibeamProducts < ActiveRecord::Migration

  def up

      execute <<-SQL

  INSERT INTO vendors_lists(vendor_name,vendor_logo,vendor_description,business_type,vendor_website,vendor_email,vendor_phone,vendor_fax,
vendor_address,latitude,longitude,city_name,branch_name,working_time,miscellaneous,vendor_sub_categories,monetization_type,subscribed_date,trial_flag,created_at) values('Infibeam','/Images/Vendor_Logos/infibeam.png','An Online Shop','online','www.infibeam.com','feedback@infibeam.in','08049091234','na', '9th Floor,A-Wing,Gopal Palace,Nehrunagar,Ahmedabad. Gujarat. India - 380015.','na','na','na','na','na','COD',
'desktops_lists,headsets_lists,laptops_lists,pendrives_lists,keyboards_lists,headphones_lists,printers_lists,tablets_lists,routers_lists,mouses_lists,speakers_lists','purchase','2012-07-07','n',now());

	SQL

  execute <<-SQL

  CREATE TABLE IF NOT EXISTS online_infibeam_products (
  product_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  product_image_url TEXT,
  product_category VARCHAR(255) NOT NULL,
  product_sub_category VARCHAR(255) NOT NULL,
  product_identifier1 VARCHAR(255) NOT NULL,
  product_identifier2 VARCHAR(255) NOT NULL,
  product_price DOUBLE NOT NULL,
  product_shipping_cost DOUBLE NOT NULL,
  product_shipping_time VARCHAR(255) NOT NULL,
  product_availability VARCHAR (255) NOT NULL,
  product_redirect_url TEXT NOT NULL,
  product_special_offers TEXT,
  product_warranty TEXT,
  reason VARCHAR(255) NOT NULL,
  validity VARCHAR(255) NOT NULL,
  configured_by VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (product_id),
  UNIQUE (product_name, product_identifier1, product_identifier2)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

    execute <<-SQL

    CREATE TRIGGER t_Insert_online_infibeam_products AFTER INSERT ON online_infibeam_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_sub_category_id INT(3);

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'online';

    DECLARE v_DebugID VARCHAR(255);



	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='infibeam';

	SET v_DebugID = concat('ionlinev',v_VendorID,'p',new.product_id);






        call p_insert_update_delete_products_table(   v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     new.product_id,
                                                     new.product_name,
                                                     new.product_image_url,
						     new.product_category,
						     new.product_sub_category,
						     new.product_identifier1,
						     new.product_identifier2,
                                                     new.product_price,
  						     new.product_availability,
                                                     new.product_shipping_cost,
                                                     new.product_shipping_time,
						     new.product_special_offers,
						     new.product_warranty,
						     new.product_redirect_url,
						     NULL,
						     new.reason,
						     new.validity,
						     new.configured_by);
    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Update_online_infibeam_products AFTER UPDATE ON online_infibeam_products
    FOR EACH ROW
    BEGIN



    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 0;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'online';

    DECLARE v_DebugID VARCHAR(255);

	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='infibeam';

SET v_DebugID = concat('uonlinev',v_VendorID,'p',new.product_id);

  call p_insert_update_delete_products_table(  v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     new.product_id,
                                                     new.product_name,
                                                     new.product_image_url,
						     new.product_category,
						     new.product_sub_category,
						     new.product_identifier1,
						     new.product_identifier2,
                                                     new.product_price,
  						     new.product_availability,
                                                     new.product_shipping_cost,
                                                     new.product_shipping_time,
						     new.product_special_offers,
						     new.product_warranty,
						     new.product_redirect_url,
						     NULL,
						     new.reason,
						     new.validity,
						     new.configured_by);


    END;

    SQL

    execute <<-SQL

    CREATE TRIGGER t_Delete_online_infibeam_products BEFORE DELETE ON online_infibeam_products
    FOR EACH ROW
    BEGIN


    DECLARE v_VendorID INT;

    DECLARE v_delete_flag INT DEFAULT 1;

    DECLARE v_type_flag VARCHAR(255) DEFAULT 'online';

    DECLARE v_DebugID VARCHAR(255);


	SELECT vendor_id INTO v_VendorID FROM vendors_lists WHERE vendor_name='infibeam';

	SET v_DebugID = concat('donlinev',v_VendorID,'p',old.product_id);

 call p_insert_update_delete_products_table(    v_delete_flag,
                                                     v_DebugID,
						     v_type_flag,
						     v_VendorID,
                                                     old.product_id,
                                                     old.product_name,
                                                     old.product_image_url,
						     old.product_category,
						     old.product_sub_category,
						     old.product_identifier1,
						     old.product_identifier2,
                                                     old.product_price,
  						     old.product_availability,
                                                     old.product_shipping_cost,
                                                     old.product_shipping_time,
						     old.product_special_offers,
						     old.product_warranty,
						     old.product_redirect_url,
						     NULL,
						     old.reason,
						     old.validity,
						     old.configured_by);


    END;

    SQL

  end



  def down

	execute "DELETE FROM online_infibeam_products"
	execute "call p_drop_online_vendor('infibeam')"
        execute "DROP TRIGGER t_Delete_online_infibeam_products"
        execute "DROP TRIGGER t_Update_online_infibeam_products"
        execute "DROP TRIGGER t_Insert_online_infibeam_products"
        execute "DROP TABLE online_infibeam_products"
        system "rails destroy model online_infibeam_products"
  end
end

