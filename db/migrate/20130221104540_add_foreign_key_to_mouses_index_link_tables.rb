class AddForeignKeyToMousesIndexLinkTables < ActiveRecord::Migration
   
  def up

	execute <<-SQL
	ALTER TABLE link_f1_mouses_lists
	ADD CONSTRAINT fk_links_mouses_list
        FOREIGN KEY (mouses_list_id)
        REFERENCES mouses_lists(mouses_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_mouses_lists
        ADD CONSTRAINT fk_links_mouses_features
        FOREIGN KEY (feature_id)
        REFERENCES mouses_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_mouses_lists
        ADD CONSTRAINT fk_link_f2_vendor_mouses_lists
        FOREIGN KEY (mouses_list_id)
        REFERENCES mouses_lists(mouses_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_mouses_lists
        ADD CONSTRAINT fk_link_f2_vendor_mouses_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES mouses_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_mouses_lists
        ADD CONSTRAINT fk_link_f2_vendor_mouses_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_mouses_lists DROP FOREIGN KEY fk_links_mouses_list"
	execute "ALTER TABLE link_f1_mouses_lists DROP FOREIGN KEY fk_links_mouses_features"
	execute "ALTER TABLE link_f2_vendor_mouses_lists DROP FOREIGN KEY fk_link_f2_vendor_mouses_lists"
	execute "ALTER TABLE link_f2_vendor_mouses_lists DROP FOREIGN KEY fk_link_f2_vendor_mouses_lists_availability"
	execute "ALTER TABLE link_f2_vendor_mouses_lists DROP FOREIGN KEY fk_link_f2_vendor_mouses_lists_vendor"
	

  end

end
