class AddForeignKeyToDesktopsIndexLinkTables < ActiveRecord::Migration
  
  def up

	execute <<-SQL
	ALTER TABLE link_f1_desktops_lists
	ADD CONSTRAINT fk_links_desktops_list
        FOREIGN KEY (desktops_list_id)
        REFERENCES desktops_lists(desktops_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_desktops_lists
        ADD CONSTRAINT fk_links_desktops_features
        FOREIGN KEY (feature_id)
        REFERENCES desktops_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_desktops_lists
        ADD CONSTRAINT fk_link_f2_vendor_desktops_lists
        FOREIGN KEY (desktops_list_id)
        REFERENCES desktops_lists(desktops_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_desktops_lists
        ADD CONSTRAINT fk_link_f2_vendor_desktops_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES desktops_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_desktops_lists
        ADD CONSTRAINT fk_link_f2_vendor_desktops_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_desktops_lists DROP FOREIGN KEY fk_links_desktops_list"
	execute "ALTER TABLE link_f1_desktops_lists DROP FOREIGN KEY fk_links_desktops_features"
	execute "ALTER TABLE link_f2_vendor_desktops_lists DROP FOREIGN KEY fk_link_f2_vendor_desktops_lists"
	execute "ALTER TABLE link_f2_vendor_desktops_lists DROP FOREIGN KEY fk_link_f2_vendor_desktops_lists_availability"
	execute "ALTER TABLE link_f2_vendor_desktops_lists DROP FOREIGN KEY fk_link_f2_vendor_desktops_lists_vendor"
	

  end

end
