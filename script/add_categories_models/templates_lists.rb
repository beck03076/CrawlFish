class <<PATTERN>>sLists < ActiveRecord::Base

  include ModelsMethods


  def self.get_identifier_from_id(product_id)

    where("<<pattern>>s_list_id = ?", product_id).first.<<pattern>>_part_no

  end
  
  def self.check_distinct_product_name_count(<<pattern>>s_list_id_array)

     where(:<<pattern>>s_list_id => <<pattern>>s_list_id_array).select("distinct(<<pattern>>_name)").size

   end

end
