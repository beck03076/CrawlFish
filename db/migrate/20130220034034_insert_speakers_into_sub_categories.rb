class InsertSpeakersIntoSubCategories < ActiveRecord::Migration

   def up

	execute "INSERT INTO subcategories(sub_category_name,category_id,category_name,created_at) values('speakers_lists',10,'speakers',CURRENT_TIMESTAMP)"

  end

  def down

	execute "delete from subcategories where sub_category_name = 'speakers_lists'"

  end

end
