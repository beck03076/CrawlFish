class AddForeignKeyToExternalHddsIndexLinkTables < ActiveRecord::Migration

  def up

	execute <<-SQL
	ALTER TABLE link_f1_external_hdds_lists
	ADD CONSTRAINT fk_links_external_hdds_list
        FOREIGN KEY (external_hdds_list_id)
        REFERENCES external_hdds_lists(external_hdds_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_external_hdds_lists
        ADD CONSTRAINT fk_links_external_hdds_features
        FOREIGN KEY (feature_id)
        REFERENCES external_hdds_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_external_hdds_lists
        ADD CONSTRAINT fk_link_f2_vendor_external_hdds_lists
        FOREIGN KEY (external_hdds_list_id)
        REFERENCES external_hdds_lists(external_hdds_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_external_hdds_lists
        ADD CONSTRAINT fk_link_f2_vendor_external_hdds_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES external_hdds_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_external_hdds_lists
        ADD CONSTRAINT fk_link_f2_vendor_external_hdds_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_external_hdds_lists DROP FOREIGN KEY fk_links_external_hdds_list"
	execute "ALTER TABLE link_f1_external_hdds_lists DROP FOREIGN KEY fk_links_external_hdds_features"
	execute "ALTER TABLE link_f2_vendor_external_hdds_lists DROP FOREIGN KEY fk_link_f2_vendor_external_hdds_lists"
	execute "ALTER TABLE link_f2_vendor_external_hdds_lists DROP FOREIGN KEY fk_link_f2_vendor_external_hdds_lists_availability"
	execute "ALTER TABLE link_f2_vendor_external_hdds_lists DROP FOREIGN KEY fk_link_f2_vendor_external_hdds_lists_vendor"
	

  end

end
