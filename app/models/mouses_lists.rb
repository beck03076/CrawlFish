class MousesLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes mouse_name,mouse_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("mouses_list_id = ?", product_id).first.mouse_part_no

  end
  
  def self.check_distinct_product_name_count(mouses_list_id_array)

     where(:mouses_list_id => mouses_list_id_array).select("distinct(mouse_name)").size

   end

end
