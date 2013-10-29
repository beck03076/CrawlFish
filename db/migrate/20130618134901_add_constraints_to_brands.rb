class AddConstraintsToBrands < ActiveRecord::Migration
  def up
      execute "ALTER TABLE brands ADD CONSTRAINT b_sc_id UNIQUE (name,scid)"    
  end
  
  def down
    execute "ALTER TABLE brands DROP INDEX b_sc_id"  
  end
end

