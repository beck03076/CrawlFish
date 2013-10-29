class InsertMousesIntoSubCategories < ActiveRecord::Migration
 
  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('mouses_lists',8,'mouses',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'mouses_lists'"

  end

end
