class InsertDesktopsIntoSubCategories < ActiveRecord::Migration
 
 def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('desktops_lists',4,'desktops',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'desktops_lists'"

  end

end
