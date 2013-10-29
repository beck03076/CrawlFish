class InsertRoutersIntoSubCategories < ActiveRecord::Migration

  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('routers_lists',7,'routers',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'routers_lists'"

  end

end
