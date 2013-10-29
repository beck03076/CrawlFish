class InsertLaptopsIntoSubCategories < ActiveRecord::Migration

  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('laptops_lists',3,'laptops',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'laptops_lists'"

  end

end
