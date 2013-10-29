class AddForeignKeyToTabletsIndexLinkTables < ActiveRecord::Migration

   def up

	execute <<-SQL
	ALTER TABLE link_f1_tablets_lists
	ADD CONSTRAINT fk_links_tablets_list
        FOREIGN KEY (tablets_list_id)
        REFERENCES tablets_lists(tablets_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_tablets_lists
        ADD CONSTRAINT fk_links_tablets_features
        FOREIGN KEY (feature_id)
        REFERENCES tablets_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_tablets_lists
        ADD CONSTRAINT fk_link_f2_vendor_tablets_lists
        FOREIGN KEY (tablets_list_id)
        REFERENCES tablets_lists(tablets_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_tablets_lists
        ADD CONSTRAINT fk_link_f2_vendor_tablets_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES tablets_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_tablets_lists
        ADD CONSTRAINT fk_link_f2_vendor_tablets_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_tablets_lists DROP FOREIGN KEY fk_links_tablets_list"
	execute "ALTER TABLE link_f1_tablets_lists DROP FOREIGN KEY fk_links_tablets_features"
	execute "ALTER TABLE link_f2_vendor_tablets_lists DROP FOREIGN KEY fk_link_f2_vendor_tablets_lists"
	execute "ALTER TABLE link_f2_vendor_tablets_lists DROP FOREIGN KEY fk_link_f2_vendor_tablets_lists_availability"
	execute "ALTER TABLE link_f2_vendor_tablets_lists DROP FOREIGN KEY fk_link_f2_vendor_tablets_lists_vendor"
	

  end

end
