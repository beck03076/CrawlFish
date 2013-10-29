class LinkF3MobilesLists < ActiveRecord::Base

  belongs_to :mobiles, :class_name => "MobilesLists", :foreign_key => "mobiles_list_id"
  belongs_to :mobile_types, :class_name => "MobilesF3MobileType", :foreign_key => "mobile_type_id"

end
