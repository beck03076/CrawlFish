class Sms < ActiveRecord::Base

  def self.raise_request(type,phone_number,vendor_id,product_id,sub_category_id)

    if type.to_s == "mobile"

      create(:mobile_number => phone_number,:vendor_id => vendor_id,:product_id => product_id,:sub_category_id => sub_category_id)

      puts "SMS LOGGER: Sms request raised for #{type}, #{phone_number},#{vendor_id},#{product_id},#{sub_category_id}"

    elsif type.to_s == "landline"

      create(:landline_number => phone_number,:vendor_id => vendor_id,:product_id => product_id,:sub_category_id => sub_category_id)

      puts "SMS LOGGER: Sms request raised for #{type}, #{phone_number},#{vendor_id},#{product_id},#{sub_category_id}"

    end

  end


  def self.get_sms_leads(month=0,year=0,vendor_id)

	if(month.to_i!=0 && year.to_i!=0 && !vendor_id.nil?)

		leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id=sms.product_id INNER JOIN local_grid_details ON local_grid_details.unique_id=link_products_lists_vendors.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=sms.vendor_id INNER JOIN mobiles_lists ON sms.product_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND MONTH(sms.created_at)=? AND YEAR(sms.created_at)=? AND link_products_lists_vendors.vendor_id=?",vendor_id,month.to_i,year.to_i,vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,sms.mobile_number,sms.created_at")

	elsif(year.to_i!=0 && !vendor_id.nil?)

		leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id=sms.product_id INNER JOIN local_grid_details ON local_grid_details.unique_id=link_products_lists_vendors.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=sms.vendor_id INNER JOIN mobiles_lists ON sms.product_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND YEAR(sms.created_at)=? AND link_products_lists_vendors.vendor_id=?",vendor_id,year.to_i,vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,sms.mobile_number,sms.created_at")

	else

		leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id=sms.product_id INNER JOIN local_grid_details ON local_grid_details.unique_id=link_products_lists_vendors.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=sms.vendor_id INNER JOIN mobiles_lists ON sms.product_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND link_products_lists_vendors.vendor_id=?",vendor_id,vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,sms.mobile_number,sms.created_at")

	end
		all_time_leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id=sms.product_id INNER JOIN local_grid_details ON local_grid_details.unique_id=link_products_lists_vendors.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=sms.vendor_id INNER JOIN mobiles_lists ON sms.product_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND link_products_lists_vendors.vendor_id=?",vendor_id,vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,sms.mobile_number,sms.created_at")

	return leads,all_time_leads
  end

  def self.get_leads(vendor_id)
	
	joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id=sms.product_id INNER JOIN local_grid_details ON local_grid_details.unique_id=link_products_lists_vendors.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=sms.vendor_id INNER JOIN mobiles_lists ON sms.product_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND link_products_lists_vendors.vendor_id=?",vendor_id,vendor_id).select("local_grid_details.price")

  end


end

