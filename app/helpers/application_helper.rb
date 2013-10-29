module ApplicationHelper


  def to_u(input)

    input.gsub!(/(.)([A-Z])/,'\1_\2').downcase!

  end

  def ad_list_details_count_function(which_page,ad_list_details_id)

	@ad_list_details_count = AdListDetailsCounts.new
	@ad_list_details_count.ad_list_details_id = ad_list_details_id
	@ad_list_details_count.displayed_page = which_page

	if @ad_list_details_count.save
	
		puts "successfully inserted record in ad_list_details_count table"
	else
		puts "there was an issue while inserting record in ad_list_details_count table"
	end
  end

  def get_last_login_date(vendor_id=0)

	TempMerchantLogs.where("vendor_id=?",vendor_id).select("log_date").order("log_date DESC,login_time DESC").first
  end

end

