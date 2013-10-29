class AddForeignKeyToHeadsetsIndexLinkTables < ActiveRecord::Migration

   def up

	execute <<-SQL
	ALTER TABLE link_f1_headsets_lists
	ADD CONSTRAINT fk_links_headsets_list
        FOREIGN KEY (headsets_list_id)
        REFERENCES headsets_lists(headsets_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_headsets_lists
        ADD CONSTRAINT fk_links_headsets_features
        FOREIGN KEY (feature_id)
        REFERENCES headsets_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headsets_lists
        ADD CONSTRAINT fk_link_f2_vendor_headsets_lists
        FOREIGN KEY (headsets_list_id)
        REFERENCES headsets_lists(headsets_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headsets_lists
        ADD CONSTRAINT fk_link_f2_vendor_headsets_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES headsets_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headsets_lists
        ADD CONSTRAINT fk_link_f2_vendor_headsets_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_headsets_lists DROP FOREIGN KEY fk_links_headsets_list"
	execute "ALTER TABLE link_f1_headsets_lists DROP FOREIGN KEY fk_links_headsets_features"
	execute "ALTER TABLE link_f2_vendor_headsets_lists DROP FOREIGN KEY fk_link_f2_vendor_headsets_lists"
	execute "ALTER TABLE link_f2_vendor_headsets_lists DROP FOREIGN KEY fk_link_f2_vendor_headsets_lists_availability"
	execute "ALTER TABLE link_f2_vendor_headsets_lists DROP FOREIGN KEY fk_link_f2_vendor_headsets_lists_vendor"
	

  end

end
