class InsertHeadsetsIntoSubCategories < ActiveRecord::Migration

  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('headsets_lists',14,'headsets',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'headsets_lists'"

  end

end
