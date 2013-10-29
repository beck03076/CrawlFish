class AddSlugs < ActiveRecord::Migration

  def up
   
    ["mobiles_lists", "laptops_lists", "desktops_lists", "external_hdds_lists", "printers_lists", "routers_lists", "mouses_lists", "keyboards_lists", "speakers_lists", "memory_cards_lists", "pendrives_lists", "headphones_lists", "headsets_lists", "tablets_lists"].each do |i|
    
            if !(i.camelize.constantize.column_names.include?("name_slug"))
            execute <<-SQL
                ALTER TABLE #{i} ADD name_slug TEXT ;
            SQL
            end
            
            if !(i.camelize.constantize.column_names.include?("identifier_slug"))
            execute <<-SQL
                ALTER TABLE #{i} ADD identifier_slug TEXT AFTER name_slug;
            SQL
            end
    
    end

  end

end
