class ExternalHddsLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes external_hdd_name,external_hdd_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("external_hdds_list_id = ?", product_id).first.external_hdd_part_no

  end
  
  def self.check_distinct_product_name_count(external_hdds_list_id_array)

     where(:external_hdds_list_id => external_hdds_list_id_array).select("distinct(external_hdd_name)").size

   end

end
