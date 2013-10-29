class AddForeignKeyToKeyboardsIndexLinkTables < ActiveRecord::Migration

   def up

	execute <<-SQL
	ALTER TABLE link_f1_keyboards_lists
	ADD CONSTRAINT fk_links_keyboards_list
        FOREIGN KEY (keyboards_list_id)
        REFERENCES keyboards_lists(keyboards_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_keyboards_lists
        ADD CONSTRAINT fk_links_keyboards_features
        FOREIGN KEY (feature_id)
        REFERENCES keyboards_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_keyboards_lists
        ADD CONSTRAINT fk_link_f2_vendor_keyboards_lists
        FOREIGN KEY (keyboards_list_id)
        REFERENCES keyboards_lists(keyboards_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_keyboards_lists
        ADD CONSTRAINT fk_link_f2_vendor_keyboards_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES keyboards_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_keyboards_lists
        ADD CONSTRAINT fk_link_f2_vendor_keyboards_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_keyboards_lists DROP FOREIGN KEY fk_links_keyboards_list"
	execute "ALTER TABLE link_f1_keyboards_lists DROP FOREIGN KEY fk_links_keyboards_features"
	execute "ALTER TABLE link_f2_vendor_keyboards_lists DROP FOREIGN KEY fk_link_f2_vendor_keyboards_lists"
	execute "ALTER TABLE link_f2_vendor_keyboards_lists DROP FOREIGN KEY fk_link_f2_vendor_keyboards_lists_availability"
	execute "ALTER TABLE link_f2_vendor_keyboards_lists DROP FOREIGN KEY fk_link_f2_vendor_keyboards_lists_vendor"
	

  end

end
