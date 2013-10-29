class PendrivesLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes pendrive_name,pendrive_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("pendrives_list_id = ?", product_id).first.pendrive_part_no

  end
  
  def self.check_distinct_product_name_count(pendrives_list_id_array)

     where(:pendrives_list_id => pendrives_list_id_array).select("distinct(pendrive_name)").size

   end

end
