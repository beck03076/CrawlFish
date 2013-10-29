class LinkF5MobilesLists < ActiveRecord::Base

  belongs_to :mobiles, :class_name => "MobilesLists", :foreign_key => "mobiles_list_id"
  belongs_to :mobile_os_versions, :class_name => "MobilesF5OsVersion", :foreign_key => "mobile_os_version_id"

end
