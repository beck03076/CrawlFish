class TabletsLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes tablet_name,tablet_part_no
  end

  def self.get_identifier_from_id(product_id)

    where("tablets_list_id = ?", product_id).first.tablet_part_no

  end
  
  def self.check_distinct_product_name_count(tablets_list_id_array)

     where(:tablets_list_id => tablets_list_id_array).select("distinct(tablet_name)").size

   end

end
