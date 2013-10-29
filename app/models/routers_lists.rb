class RoutersLists < ActiveRecord::Base

  include ModelsMethods
  
  define_index do
    indexes router_name,router_part_no
  end



  def self.get_identifier_from_id(product_id)

    where("routers_list_id = ?", product_id).first.router_part_no

  end
  
  def self.check_distinct_product_name_count(routers_list_id_array)

     where(:routers_list_id => routers_list_id_array).select("distinct(router_name)").size

   end

end
