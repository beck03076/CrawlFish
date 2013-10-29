class HeadsetsLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes headset_name,headset_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("headsets_list_id = ?", product_id).first.headset_part_no

  end
  
  def self.check_distinct_product_name_count(headsets_list_id_array)

     where(:headsets_list_id => headsets_list_id_array).select("distinct(headset_name)").size

   end

end
