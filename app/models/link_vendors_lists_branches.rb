class LinkVendorsListsBranches < ActiveRecord::Base

  belongs_to :branches, :class_name => "Branches", :foreign_key => "branch_id"
  belongs_to :vendors, :class_name => "VendorsList", :foreign_key => "vendor_id"

  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "vendor_id",
  :conditions => ['link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?', 2 , 3]
  has_many :grids, :through => :vendorlinks, :class_name => "LocalGridDetails", :foreign_key => "unique_id"

  def self.get_other_linked_branches(vendor_name)

    joins("INNER JOIN vendors_lists ON link_vendors_lists_branches.vendor_id = vendors_lists.vendor_id INNER JOIN branches ON branches.branch_id = link_vendors_lists_branches.branch_id").where("vendors_lists.vendor_name = ? AND branches.branch_name != vendors_lists.branch_name", vendor_name).select("branches.branch_name").all

  end


  def self.get_areas_from_sub_category_name(sub_category_name)

    joins("INNER JOIN vendors_lists ON link_vendors_lists_branches.vendor_id = vendors_lists.vendor_id INNER JOIN branches ON branches.branch_id = link_vendors_lists_branches.branch_id ").where("find_in_set(?,vendor_sub_categories) <> 0",sub_category_name).select("distinct(branches.branch_name) as areas").all

  end

end

