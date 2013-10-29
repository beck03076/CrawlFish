class AddForeignKeyToSpeakersIndexLinkTables < ActiveRecord::Migration

 def up

	execute <<-SQL
	ALTER TABLE link_f1_speakers_lists
	ADD CONSTRAINT fk_links_speakers_list
        FOREIGN KEY (speakers_list_id)
        REFERENCES speakers_lists(speakers_list_id)
  	SQL

	execute <<-SQL
	ALTER TABLE link_f1_speakers_lists
        ADD CONSTRAINT fk_links_speakers_features
        FOREIGN KEY (feature_id)
        REFERENCES speakers_f1_features(feature_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_speakers_lists
        ADD CONSTRAINT fk_link_f2_vendor_speakers_lists
        FOREIGN KEY (speakers_list_id)
        REFERENCES speakers_lists(speakers_list_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_speakers_lists
        ADD CONSTRAINT fk_link_f2_vendor_speakers_lists_availability
        FOREIGN KEY (availability_id)
        REFERENCES speakers_vendor_f2_availabilities(availability_id)
    	SQL

	execute <<-SQL
	ALTER TABLE link_f2_vendor_speakers_lists
        ADD CONSTRAINT fk_link_f2_vendor_speakers_lists_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors_lists(vendor_id)
    	SQL

  end

  def down

	execute "ALTER TABLE link_f1_speakers_lists DROP FOREIGN KEY fk_links_speakers_list"
	execute "ALTER TABLE link_f1_speakers_lists DROP FOREIGN KEY fk_links_speakers_features"
	execute "ALTER TABLE link_f2_vendor_speakers_lists DROP FOREIGN KEY fk_link_f2_vendor_speakers_lists"
	execute "ALTER TABLE link_f2_vendor_speakers_lists DROP FOREIGN KEY fk_link_f2_vendor_speakers_lists_availability"
	execute "ALTER TABLE link_f2_vendor_speakers_lists DROP FOREIGN KEY fk_link_f2_vendor_speakers_lists_vendor"
	

  end

end
