class SpeakersLists < ActiveRecord::Base

  include ModelsMethods
  define_index do
    indexes speaker_name,speaker_part_no
  end


  def self.get_identifier_from_id(product_id)

    where("speakers_list_id = ?", product_id).first.speaker_part_no

  end
  
  def self.check_distinct_product_name_count(speakers_list_id_array)

     where(:speakers_list_id => speakers_list_id_array).select("distinct(speaker_name)").size

   end

end
