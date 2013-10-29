class VendorsList < ActiveRecord::Base

  acts_as_gmappable

  has_many :branchlinks , :class_name => "LinkVendorsListsBranches", :foreign_key => "vendor_id"
  has_many :branches, :through => :branchlinks, :class_name => "Branches" , :foreign_key => "branch_id"

  has_many :citylinks , :class_name => "LinkVendorsListsCities", :foreign_key => "vendor_id"
  has_many :cities, :through => :citylinks, :class_name => "Cities" , :foreign_key => "city_id"

  has_many :sub_category_links , :class_name => "LinkVendorsListsSubCategories", :foreign_key => "vendor_id"
  has_many :sub_categories, :through => :sub_category_links , :class_name => "Subcategories", :foreign_key => "sub_category_id"

  def self.get_vendor_by_name_branch(name,branch)

    where(:vendor_alias_name => name,:branch_name => branch)

  end

  def self.get_latitude_longitude(vendor_name,branch_name)

    where(:vendor_name => vendor_name,:branch_name => branch_name).select("latitude,longitude").map{|i| [i.latitude,i.longitude]}.flatten.join(",")

  end

  def self.get_admin_branch_name(vendor_id)

    joins("INNER JOIN branches b ON b.branch_id = vendors_lists.admin").where("vendors_lists.vendor_id IN (?)",vendor_id).select("vendors_lists.vendor_id,b.branch_name as adm")

  end

end

