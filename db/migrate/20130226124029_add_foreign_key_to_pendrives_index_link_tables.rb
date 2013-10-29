class AddForeignKeyToPendrivesIndexLinkTables < ActiveRecord::Migration

  def up

	execute <<-SQL
	ALTER TABLE link_f1_pendrives_lists
	ADD CONSTRAINT fk_links_pendrives_list
        FOREIGN KEY (pendrives_list_id)
        REFERENCES pendrives_lists(pendrives_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_pendrives_lists
        ADD CONSTRAINT fk_links_pendrives_features
        FOREIGN KEY (feature_id)
        REFERENCES pendrives_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_pendrives_lists
        ADD CONSTRAINT fk_link_f2_vendor_pendrives_lists
        FOREIGN KEY (pendrives_list_id)
        REFERENCES pendrives_lists(pendrives_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_pendrives_lists
        ADD CONSTRAINT fk_link_f2_vendor_pendrives_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES pendrives_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_pendrives_lists
        ADD CONSTRAINT fk_link_f2_vendor_pendrives_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_pendrives_lists DROP FOREIGN KEY fk_links_pendrives_list"
	execute "ALTER TABLE link_f1_pendrives_lists DROP FOREIGN KEY fk_links_pendrives_features"
	execute "ALTER TABLE link_f2_vendor_pendrives_lists DROP FOREIGN KEY fk_link_f2_vendor_pendrives_lists"
	execute "ALTER TABLE link_f2_vendor_pendrives_lists DROP FOREIGN KEY fk_link_f2_vendor_pendrives_lists_availability"
	execute "ALTER TABLE link_f2_vendor_pendrives_lists DROP FOREIGN KEY fk_link_f2_vendor_pendrives_lists_vendor"
	

  end

end
