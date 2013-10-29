class AddForeignKeyToHeadphonesIndexLinkTables < ActiveRecord::Migration

   def up

	execute <<-SQL
	ALTER TABLE link_f1_headphones_lists
	ADD CONSTRAINT fk_links_headphones_list
        FOREIGN KEY (headphones_list_id)
        REFERENCES headphones_lists(headphones_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_headphones_lists
        ADD CONSTRAINT fk_links_headphones_features
        FOREIGN KEY (feature_id)
        REFERENCES headphones_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headphones_lists
        ADD CONSTRAINT fk_link_f2_vendor_headphones_lists
        FOREIGN KEY (headphones_list_id)
        REFERENCES headphones_lists(headphones_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headphones_lists
        ADD CONSTRAINT fk_link_f2_vendor_headphones_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES headphones_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_headphones_lists
        ADD CONSTRAINT fk_link_f2_vendor_headphones_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_headphones_lists DROP FOREIGN KEY fk_links_headphones_list"
	execute "ALTER TABLE link_f1_headphones_lists DROP FOREIGN KEY fk_links_headphones_features"
	execute "ALTER TABLE link_f2_vendor_headphones_lists DROP FOREIGN KEY fk_link_f2_vendor_headphones_lists"
	execute "ALTER TABLE link_f2_vendor_headphones_lists DROP FOREIGN KEY fk_link_f2_vendor_headphones_lists_availability"
	execute "ALTER TABLE link_f2_vendor_headphones_lists DROP FOREIGN KEY fk_link_f2_vendor_headphones_lists_vendor"
	

  end

end
