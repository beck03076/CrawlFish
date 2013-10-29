class Cities < ActiveRecord::Base

  has_many :vendorlinks , :class_name => "LinkVendorsListsCities", :foreign_key => "city_id"
  has_many :vendors, :through => :vendorlinks, :class_name => "VendorsList" , :foreign_key => "vendor_id"

  has_many :areas , :class_name => "Branches", :foreign_key => "city_id"


end

