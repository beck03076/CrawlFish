class KeyboardsLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes keyboard_name,keyboard_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("keyboards_list_id = ?", product_id).first.keyboard_part_no

  end
  
  def self.check_distinct_product_name_count(keyboards_list_id_array)

     where(:keyboards_list_id => keyboards_list_id_array).select("distinct(keyboard_name)").size

   end

end
