class MobilesRates < ActiveRecord::Base

  def self.get_mrp(mobiles_list_id = 0)

      if (mobiles_list_id != 0)

         mrp = where(:mobiles_list_id => mobiles_list_id).select("mrp").map{|i| i.mrp }.join

         (!mrp.empty?) ? mrp : 0

      else

         0

      end

  end

end

