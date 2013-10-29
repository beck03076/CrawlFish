class PendrivesF1Features  < ActiveRecord::Base

   def self.get_display_name(feature_id)

    where("feature_id IN (?)", feature_id ).select("feature_name").map {|v| v.feature_name}

  end
end
