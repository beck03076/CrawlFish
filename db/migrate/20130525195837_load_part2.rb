class LoadPart2 < ActiveRecord::Migration

  def up
    p "Passed path is #{ENV['PATH']}  .."
    ENV['PATH'].split(",").each do |x|    
        Dir.glob(x + "/*").select {|i| File.file? i}.each do |f|
        
            tab = File.basename(f)
            p "Loading #{f} into #{tab}..."
            execute <<-SQL

              LOAD DATA LOCAL INFILE '#{f}' INTO TABLE #{tab} FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;

            SQL
        
        end
    end

  end

end
