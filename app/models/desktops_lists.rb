class DesktopsLists < ActiveRecord::Base

  include ModelsMethods
  
  define_index do
    indexes desktop_name,desktop_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("desktops_list_id = ?", product_id).first.desktop_part_no

  end
  
  def self.check_distinct_product_name_count(desktops_list_id_array)

     where(:desktops_list_id => desktops_list_id_array).select("distinct(desktop_name)").size

   end

end
