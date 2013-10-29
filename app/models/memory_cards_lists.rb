class MemoryCardsLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes memory_card_name,memory_card_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("memory_cards_list_id = ?", product_id).first.memory_card_part_no

  end
  
  def self.check_distinct_product_name_count(memory_cards_list_id_array)

     where(:memory_cards_list_id => memory_cards_list_id_array).select("distinct(memory_card_name)").size

   end

end
