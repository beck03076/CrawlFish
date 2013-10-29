class AndGoCoupons < ActiveRecord::Base

  def self.generate_andgo_coupon_code(vendor_id,product_name,sub_category_id,cc_mobile_number,price)

	status_code = "false"

        code = ""

	generate_new_code = 0

	coupon_code_record = AndGoCoupons.where("vendor_id = ? AND product_name = ? AND sub_category_id = ? AND customer_phone_number = ?",vendor_id,product_name,sub_category_id,cc_mobile_number).select("coupon_code").first

        if(!coupon_code_record.nil?)
		
		generate_new_code = 1

	end

	if(generate_new_code == 0)

	until status_code =="true"
	
	  chars = ("a".."z").to_a + ("0".."9").to_a

  	  code = Array.new(10, '').collect{chars[rand(chars.size)]}.join

	  coupon = AndGoCoupons.find_or_initialize_by_vendor_id_and_coupon_code(vendor_id, code)

	  coupon.product_name = product_name

	  coupon.sub_category_id = sub_category_id
	
          coupon.price = price

	  coupon.customer_phone_number = cc_mobile_number

	  vendor_coupons = VendorCoupons.where("vendor_id=? AND coupon_code = ?",vendor_id,code)

	  if(vendor_coupons.count==0)	  

	  	status = coupon.save! if coupon.new_record?
	  
	  else

		status = "false"

	  end 

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

end
