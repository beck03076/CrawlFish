class SponsoredSellerAreaListings < ActiveRecord::Base

  def self.find_sponsored_vendor_details(product_id,sub_category_id,area_id)
	
	#Variable Declaration and Initialization
	brand_name = ""
	mobile_brands_id = ""
	branch_id = ""
	vendor_listing_details = ""

	#obtain brand_name from respective part-2 tables and obtain its mobile_brands_id from mobile_brands table
	#this assumes that city_id is 1
	if(sub_category_id == 2)
	
		brand_name =(MobilesLists.where("mobiles_list_id = ?",product_id).select("mobile_brand").first).mobile_brand

        end

	mobile_brands_id = (MobileBrands.where("mobile_brand_name = ?",brand_name.downcase).select("mobile_brands_id").first).mobile_brands_id

	#branch_id is set
	branch_id = area_id

	vendor_listing_details = SponsoredSellerAreaListings.where("branch_id = ? AND mobile_brands_id = ?",branch_id,mobile_brands_id).select("vendor_id").all

	vendor_listing_details

  end

end
