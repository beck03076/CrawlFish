class AddColsToSubcategories < ActiveRecord::Migration
#Postions List
    #0. Ids, 1.Brands, 2.Names, 3.Identifier1, 4.Image_url, 5.Availability_table_name,6.Features Index, 7. product_availability_flag, 8. Features to Display in generic results, 9. Price steps
  def change
    add_column :subcategories, :id_name, :string
    add_column :subcategories, :brand, :string
    add_column :subcategories, :name, :string
    add_column :subcategories, :id1, :string
    add_column :subcategories, :url, :string
    add_column :subcategories, :avl, :string
    add_column :subcategories, :ft, :string    
    add_column :subcategories, :avl_flag, :string
    add_column :subcategories, :ft_disp, :text
    add_column :subcategories, :p_step, :text
  end
end
