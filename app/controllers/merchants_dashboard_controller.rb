class MerchantsDashboardController < ApplicationController

  before_filter :login_required , :set_cache_buster

# functions defined after this section are direct
#================ Direct Functions - START ================

  def index

      # This variable is set to make the tab highlighted when its clicked.
      @from = "dashboard"

      # This method is called from application_controller, this will set the logged_in_login_name instance variable which will always hold the login_name using which the merchant authenticated.
      set_logged_in_merchant

      if (params[:vendor_id].nil?)
      #This method is called from the same file to set the type, vendor and vendor_id instance variables from the current_merchant method called from application_controller which creates a current_merchant instance variable based on the vendor_id mapped to the current login_name and password.
        set_type_vendor_vendor_id

      else
        #This method is called from the same file to set the type, vendor and vendor_id instance variables from the vendor_id chosen by a default vendor from the select drop down menu.
        set_type_vendor_vendor_id(params[:vendor_id].to_i)

      end

      # This method is called from the same file to set the impressions, clicks and options instance variables
      self.set_impressions_clicks_options

      # This method is called from the same file to set the branches select drop down which will display the list of branches for the current vendor.
      set_branches(@vendor.first.vendor_name)

      # This method is called from the same file to set the most_recognized_clicks and most_recognized_impressions instance variables.
      self.set_most_recognized_impressions_clicks

      # This method is called from the same file to obtain count of coupon code and SMS and leads genrerated through coupon code and SMS
      self.get_leads_count

	if(!session[:notifications_count].nil?)
		title = "CrawlFish - Merchant Login - Dashboard"
		get_vendor_coupons_count(@vendor_id.to_i,title)
	else
		@meta_merchant_login_title = 'CrawlFish - Merchant Login - Dashboard'
	end
  end

  def data_feed

    merchants_index_preliminary_actions

    render ('merchants_dashboard/data_feed')

  end

  def categorize

    if !(params[:vendor_id].to_i == 0)


        @sub_category_id = params[:sub_category_id].to_i

        @vendor_id = params[:vendor_id].to_i

        puts "this is sub_category_id #{@sub_category_id}"

        @impressions = VendorProductTransactionsLogs.get_total_count(@vendor_id,"page_impressions_count",@sub_category_id)

        @clicks = VendorProductTransactionsLogs.get_total_count(@vendor_id,"button_clicks_count",@sub_category_id)

        puts "this is impressions #{@total_impressions}.."

        puts "this is clicks #{@total_clicks}..."

         render :partial => "merchants_dashboard/impressions_clicks"

   else

     @message = "Invalid vendor or category!"

     render "merchants/message"

   end

  end

  def range

    from_date = params[:from_date].to_s

    to_date = params[:to_date].to_s

    sub_category_id = params[:sub_category_id].to_i

    vendor_id = params[:vendor_id].to_i

    puts "the value of vendor_id is #{vendor_id}.."

    puts "the value of sub_category_id is #{sub_category_id}.."


    @impressions = VendorProductTransactionsLogs.get_range("page_impressions_count",vendor_id,from_date,to_date,sub_category_id)

    @clicks = VendorProductTransactionsLogs.get_range("button_clicks_count",vendor_id,from_date,to_date,sub_category_id)


    render :partial => "merchants_dashboard/impressions_clicks"

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def get_leads_count

	@cc_count=VendorCoupons.where("vendor_id = ?",@vendor_id).count

	@sms_count=Sms.where("vendor_id = ?",@vendor_id).count

	@cc_lead=VendorCoupons.get_leads(@vendor_id).collect(&:price).sum.to_i

	@sms_lead=Sms.get_leads(@vendor_id).collect(&:price).sum.to_i
	
  end

  def set_impressions_clicks_options

      @impressions = VendorProductTransactionsLogs.get_total_count(@vendor_id,"page_impressions_count")

	    @clicks = VendorProductTransactionsLogs.get_total_count(@vendor_id,"button_clicks_count")

	    @options = @vendor.first.sub_categories.collect {|p| [p.category_name, p.sub_category_id] }.unshift(["All Categories", 0])

   end

   def set_most_recognized_impressions_clicks

      impressions_result = VendorProductTransactionsLogs.get_most_recognized_impressions(@vendor_id)

      clicks_result  = VendorProductTransactionsLogs.get_most_recognized_clicks(@vendor_id)
		
	  #added this on 2012aug02 to show products with greatest impression and click
      @books_impressions_result = VendorProductTransactionsLogs.get_most_recognized_books_impressions(@vendor_id)
      @mobiles_impressions_result = VendorProductTransactionsLogs.get_most_recognized_mobiles_impressions(@vendor_id)
      @books_count_result = VendorProductTransactionsLogs.get_most_recognized_books_count(@vendor_id)
      @mobiles_count_result = VendorProductTransactionsLogs.get_most_recognized_mobiles_count(@vendor_id)

	 if impressions_result == 1

	      @most_recognized_impressions = "No data to calculate the most recognized category!"

    	 else

    	   @most_recognized_impressions = impressions_result.join

      end

      if clicks_result == 1

         @most_recognized_clicks = "No data to calculate the most recognized category!"

      else

         @most_recognized_clicks = clicks_result.join

      end

   end

#================ Auxillary Functions - END ================


end

