class LoadPart1 < ActiveRecord::Migration
   def up
    
    ["/home/think/data/Part_1/2013may30Mobiles/Online_Poorvika_products"].each do |i|
    
    tab = i.split("/")[6].downcase

    execute <<-SQL

      LOAD DATA LOCAL INFILE "#{i}" INTO TABLE #{tab} FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

    SQL
    
    end

  end
end
