class InsertHeadphonesIntoSubCategories < ActiveRecord::Migration

  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('headphones_lists',13,'headphones',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'headphones_lists'"

  end

end
