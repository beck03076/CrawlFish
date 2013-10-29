class InsertPendrivesIntoSubCategories < ActiveRecord::Migration

  def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('pendrives_lists',12,'pendrives',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'pendrives_lists'"

  end

end
