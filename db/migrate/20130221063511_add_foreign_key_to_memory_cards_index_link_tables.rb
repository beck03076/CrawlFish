class AddForeignKeyToMemoryCardsIndexLinkTables < ActiveRecord::Migration
 
  def up

	execute <<-SQL
	ALTER TABLE link_f1_memory_cards_lists
	ADD CONSTRAINT fk_links_memory_cards_list
        FOREIGN KEY (memory_cards_list_id)
        REFERENCES memory_cards_lists(memory_cards_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_memory_cards_lists
        ADD CONSTRAINT fk_links_memory_cards_features
        FOREIGN KEY (feature_id)
        REFERENCES memory_cards_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_memory_cards_lists
        ADD CONSTRAINT fk_link_f2_vendor_memory_cards_lists
        FOREIGN KEY (memory_cards_list_id)
        REFERENCES memory_cards_lists(memory_cards_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_memory_cards_lists
        ADD CONSTRAINT fk_link_f2_vendor_memory_cards_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES memory_cards_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_memory_cards_lists
        ADD CONSTRAINT fk_link_f2_vendor_memory_cards_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_memory_cards_lists DROP FOREIGN KEY fk_links_memory_cards_list"
	execute "ALTER TABLE link_f1_memory_cards_lists DROP FOREIGN KEY fk_links_memory_cards_features"
	execute "ALTER TABLE link_f2_vendor_memory_cards_lists DROP FOREIGN KEY fk_link_f2_vendor_memory_cards_lists"
	execute "ALTER TABLE link_f2_vendor_memory_cards_lists DROP FOREIGN KEY fk_link_f2_vendor_memory_cards_lists_availability"
	execute "ALTER TABLE link_f2_vendor_memory_cards_lists DROP FOREIGN KEY fk_link_f2_vendor_memory_cards_lists_vendor"
	

  end

end
