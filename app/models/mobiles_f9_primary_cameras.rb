class MobilesF9PrimaryCameras < ActiveRecord::Base

  def self.get_display_name(primary_camera_id)

    where("primary_camera_id IN (?)", primary_camera_id ).select("primary_camera").map {|v| v.primary_camera}

  end
end

