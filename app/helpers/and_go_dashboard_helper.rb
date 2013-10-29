module AndGoDashboardHelper

 def get_vendor_coupons_details(vendor_id)

	#get vendor coupon details

	@all_time_leads = VendorCoupons.get_leads_for_andgo(vendor_id)

	@all_time_leads_value = @all_time_leads.collect(&:price).sum.to_i
	@all_time_leads_count = @all_time_leads.count

	this_month_leads = @all_time_leads.where("MONTH(vendor_coupons.created_at) = ? AND YEAR(vendor_coupons.created_at) =?",Date.today.month,Date.today.year)
	@this_month_leads_value = this_month_leads.collect(&:price).sum.to_i
	@this_month_leads_count = this_month_leads.count

	last_month_leads = @all_time_leads.where("MONTH(vendor_coupons.created_at) = ? AND YEAR(vendor_coupons.created_at) =?",Date.today.ago(1.month).beginning_of_month.month,Date.today.ago(1.month).beginning_of_month.year)
	@last_month_leads_value = last_month_leads.collect(&:price).sum.to_i
	@last_month_leads_count = last_month_leads.count

	last_before_month_leads = @all_time_leads.where("MONTH(vendor_coupons.created_at) = ? AND YEAR(vendor_coupons.created_at) =?",Date.today.ago(2.month).beginning_of_month.month,Date.today.ago(2.month).beginning_of_month.year)
	@last_before_month_leads_value = last_before_month_leads.collect(&:price).sum.to_i
	@last_before_month_leads_count = last_before_month_leads.count

  end


  def get_vendor_payment_details(vendor_id)

	@payment_details = FixedPayVendorsFinancials.select("*").where("vendor_id IN (?)",vendor_id).first

  end

  def get_vendor_price(price,vendor_id)

	if(price == 0)
		@actual_price = 0
	elsif
		@actual_price = price
	end

	id_name = "cf-andgo-middle-content-actual-price-" + vendor_id.to_s

	phone_id_name = "cf-andgo-middle-content-vendor-phone-" + vendor_id.to_s

	link_id_name = "cf-andgo-middle-content-send-link-" + vendor_id.to_s

	label_id_name = "cf-andgo-middle-content-label-link-" + vendor_id.to_s

	[id_name,phone_id_name,link_id_name,label_id_name]
  end

end
