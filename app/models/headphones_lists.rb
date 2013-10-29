class HeadphonesLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes headphone_name,headphone_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("headphones_list_id = ?", product_id).first.headphone_part_no

  end
  
  def self.check_distinct_product_name_count(headphones_list_id_array)

     where(:headphones_list_id => headphones_list_id_array).select("distinct(headphone_name)").size

   end

end
