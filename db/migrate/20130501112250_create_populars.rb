class CreatePopulars < ActiveRecord::Migration
  def change
    create_table :populars do |t|
      t.text :name
      t.string :brand
      t.string :category
      t.integer :p_l_id

      t.timestamps
    end
  end
end
