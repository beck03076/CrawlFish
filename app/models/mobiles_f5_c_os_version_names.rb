class MobilesF5COsVersionNames < ActiveRecord::Base

   def self.get_display_name(mobile_os_version_name_id)

    where("mobile_os_version_name_id IN (?)", mobile_os_version_name_id ).select("mobile_os_version_name").map {|v| v.mobile_os_version_name}

  end

end

