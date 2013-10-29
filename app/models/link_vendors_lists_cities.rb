class LinkVendorsListsCities < ActiveRecord::Base

  belongs_to :cities, :class_name => "Cities", :foreign_key => "city_id"
  belongs_to :vendors, :class_name => "VendorsList", :foreign_key => "vendor_id"

end

