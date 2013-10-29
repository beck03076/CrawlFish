class AddForeignKeyToPrintersIndexLinkTables < ActiveRecord::Migration

  def up

	execute <<-SQL
	ALTER TABLE link_f1_printers_lists
	ADD CONSTRAINT fk_links_printers_list
        FOREIGN KEY (printers_list_id)
        REFERENCES printers_lists(printers_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_printers_lists
        ADD CONSTRAINT fk_links_printers_features
        FOREIGN KEY (feature_id)
        REFERENCES printers_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_printers_lists
        ADD CONSTRAINT fk_link_f2_vendor_printers_lists
        FOREIGN KEY (printers_list_id)
        REFERENCES printers_lists(printers_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_printers_lists
        ADD CONSTRAINT fk_link_f2_vendor_printers_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES printers_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_printers_lists
        ADD CONSTRAINT fk_link_f2_vendor_printers_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_printers_lists DROP FOREIGN KEY fk_links_printers_list"
	execute "ALTER TABLE link_f1_printers_lists DROP FOREIGN KEY fk_links_printers_features"
	execute "ALTER TABLE link_f2_vendor_printers_lists DROP FOREIGN KEY fk_link_f2_vendor_printers_lists"
	execute "ALTER TABLE link_f2_vendor_printers_lists DROP FOREIGN KEY fk_link_f2_vendor_printers_lists_availability"
	execute "ALTER TABLE link_f2_vendor_printers_lists DROP FOREIGN KEY fk_link_f2_vendor_printers_lists_vendor"
	

  end

end
