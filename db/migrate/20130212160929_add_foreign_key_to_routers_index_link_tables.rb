class AddForeignKeyToRoutersIndexLinkTables < ActiveRecord::Migration

  def up

	execute <<-SQL
	ALTER TABLE link_f1_routers_lists
	ADD CONSTRAINT fk_links_routers_list
        FOREIGN KEY (routers_list_id)
        REFERENCES routers_lists(routers_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_routers_lists
        ADD CONSTRAINT fk_links_routers_features
        FOREIGN KEY (feature_id)
        REFERENCES routers_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_routers_lists
        ADD CONSTRAINT fk_link_f2_vendor_routers_lists
        FOREIGN KEY (routers_list_id)
        REFERENCES routers_lists(routers_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_routers_lists
        ADD CONSTRAINT fk_link_f2_vendor_routers_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES routers_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_routers_lists
        ADD CONSTRAINT fk_link_f2_vendor_routers_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_routers_lists DROP FOREIGN KEY fk_links_routers_list"
	execute "ALTER TABLE link_f1_routers_lists DROP FOREIGN KEY fk_links_routers_features"
	execute "ALTER TABLE link_f2_vendor_routers_lists DROP FOREIGN KEY fk_link_f2_vendor_routers_lists"
	execute "ALTER TABLE link_f2_vendor_routers_lists DROP FOREIGN KEY fk_link_f2_vendor_routers_lists_availability"
	execute "ALTER TABLE link_f2_vendor_routers_lists DROP FOREIGN KEY fk_link_f2_vendor_routers_lists_vendor"
	

  end

end
