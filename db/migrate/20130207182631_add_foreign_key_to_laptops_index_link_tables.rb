class AddForeignKeyToLaptopsIndexLinkTables < ActiveRecord::Migration
  
  def up

	execute <<-SQL
	ALTER TABLE link_f1_laptops_lists
	ADD CONSTRAINT fk_links_laptops
        FOREIGN KEY (laptops_list_id)
        REFERENCES laptops_lists(laptops_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_laptops_lists
        ADD CONSTRAINT fk_links_features
        FOREIGN KEY (feature_id)
        REFERENCES laptops_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_laptops_lists
        ADD CONSTRAINT fk_link_f2_vendor_laptops_lists
        FOREIGN KEY (laptops_list_id)
        REFERENCES laptops_lists(laptops_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_laptops_lists
        ADD CONSTRAINT fk_link_f2_vendor_laptops_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES laptops_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_laptops_lists
        ADD CONSTRAINT fk_link_f2_vendor_laptops_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_laptops_lists DROP FOREIGN KEY fk_links_laptops"
	execute "ALTER TABLE link_f1_laptops_lists DROP FOREIGN KEY fk_links_features"
	execute "ALTER TABLE link_f2_vendor_laptops_lists DROP FOREIGN KEY fk_link_f2_vendor_laptops_lists"
	execute "ALTER TABLE link_f2_vendor_laptops_lists DROP FOREIGN KEY fk_link_f2_vendor_laptops_lists_availability"
	execute "ALTER TABLE link_f2_vendor_laptops_lists DROP FOREIGN KEY fk_link_f2_vendor_laptops_lists_vendor"
	

  end

end
