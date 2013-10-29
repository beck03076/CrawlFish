class LaptopsLists < ActiveRecord::Base

  define_index do

    indexes laptop_name,laptop_part_no

  end

  include ModelsMethods

  def self.get_identifier_from_id(product_id)

    where("laptops_list_id = ?", product_id).first.laptop_part_no

  end
  
  def self.check_distinct_product_name_count(laptops_list_id_array)

     where(:laptops_list_id => laptops_list_id_array).select("distinct(laptop_name)").size

   end

end
