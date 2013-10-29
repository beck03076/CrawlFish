class VendorCoupons < ActiveRecord::Base

  def self.generate_coupon_code(vendor_id,unique_id,sub_category_id,cc_mobile_number,c_id   )

    status_code = "false"

        code = ""

    generate_new_code = 0

    coupon_code_record = VendorCoupons.where("vendor_id = ? AND unique_id = ? AND sub_category_id = ? AND customer_phone_number = ?",vendor_id,unique_id,sub_category_id,cc_mobile_number).select("coupon_code").first

    if(!coupon_code_record.nil?)
        
        generate_new_code = 1

    end

    if(generate_new_code == 0)

    until status_code =="true"
    
      chars = ("a".."z").to_a + ("0".."9").to_a

        code = Array.new(10, '').collect{chars[rand(chars.size)]}.join

      puts "code " + code.to_s

      coupon = VendorCoupons.find_or_initialize_by_vendor_id_and_coupon_code(vendor_id,code)

      coupon.unique_id = unique_id

      coupon.sub_category_id = sub_category_id

      coupon.customer_phone_number = cc_mobile_number
      
      coupon.c_id = c_id
        
      status = coupon.save! if coupon.new_record?

      if(status)

        status_code = "true"

        else
        status_code = "false"
      end

     end

        else
    
        if(!coupon_code_record.nil?)

            code = coupon_code_record.coupon_code

        end

    end

    return code,generate_new_code

  end


  def self.get_coupon_code_leads(month=0,year=0,vendor_id)

    if(month.to_i!=0 && year.to_i!=0 && !vendor_id.nil?)

        leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id INNER JOIN mobiles_lists ON link_products_lists_vendors.products_list_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND MONTH(vendor_coupons.created_at)=? AND YEAR(vendor_coupons.created_at)=?",vendor_id,month.to_i,year.to_i).select("mobiles_lists.mobile_name,local_grid_details.price,vendor_coupons.coupon_code,vendor_coupons.customer_phone_number,vendor_coupons.created_at")

    elsif(year.to_i!=0 && !vendor_id.nil?)

        leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id INNER JOIN mobiles_lists ON link_products_lists_vendors.products_list_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=? AND YEAR(vendor_coupons.created_at)=?",vendor_id,year.to_i).select("mobiles_lists.mobile_name,local_grid_details.price,vendor_coupons.coupon_code,vendor_coupons.customer_phone_number,vendor_coupons.created_at")

    else

        leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id INNER JOIN mobiles_lists ON link_products_lists_vendors.products_list_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=?",vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,vendor_coupons.coupon_code,vendor_coupons.customer_phone_number,vendor_coupons.created_at")

    end

        all_time_leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id INNER JOIN mobiles_lists ON link_products_lists_vendors.products_list_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=?",vendor_id).select("mobiles_lists.mobile_name,local_grid_details.price,vendor_coupons.coupon_code,vendor_coupons.customer_phone_number,vendor_coupons.created_at")

           and_go_coupons = AndGoCoupons.where("and_go_coupons.vendor_id = ?",vendor_id);

    return leads,all_time_leads,and_go_coupons

  end
  

  def self.get_leads(vendor_id)
    
    joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id INNER JOIN mobiles_lists ON link_products_lists_vendors.products_list_id=mobiles_lists.mobiles_list_id").where("vendors_lists.vendor_id=?",vendor_id).select("local_grid_details.price")

  end

  def self.get_leads_for_andgo(vendor_ids)

    all_time_leads = joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.unique_id=vendor_coupons.unique_id INNER JOIN local_grid_details ON local_grid_details.unique_id=vendor_coupons.unique_id INNER JOIN vendors_lists ON vendors_lists.vendor_id=vendor_coupons.vendor_id").where("vendors_lists.vendor_id IN (?)",vendor_ids).select("local_grid_details.price,vendors_lists.vendor_id,vendor_coupons.created_at")

    all_time_leads
  end

  end
