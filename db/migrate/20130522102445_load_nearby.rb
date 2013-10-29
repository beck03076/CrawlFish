class LoadNearby < ActiveRecord::Migration
   def up
    
    ["/home/think/data/nearby/chennai/branches","/home/think/data/nearby/chennai/temp_nearby_4kms_branches","/home/think/data/nearby/chennai/temp_nearby_2kms_branches", "/home/think/data/nearby/chennai/temp_nearby_6kms_branches"].each do |i|
    
    tab = i.split("/")[6].downcase

    execute <<-SQL

      LOAD DATA LOCAL INFILE "#{i}" INTO TABLE #{tab} FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL
    
    end

  end
end
