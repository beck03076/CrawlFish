class AddImgToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :img, :string
  end
end
