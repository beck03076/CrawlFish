class PrintersLists < ActiveRecord::Base

  define_index do
    indexes printer_name,printer_model_name
  end

  include ModelsMethods


  def self.get_identifier_from_id(product_id)

    where("printers_list_id = ?", product_id).first.printer_model_name

  end
  
  def self.check_distinct_product_name_count(printers_list_id_array)

     where(:printers_list_id => printers_list_id_array).select("distinct(printer_name)").size

   end

end
