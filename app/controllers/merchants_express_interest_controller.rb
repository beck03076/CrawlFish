class MerchantsExpressInterestController < ApplicationController

   before_filter :login_required , :set_cache_buster

   respond_to :html, :js

# functions defined after this section are direct
#================ Direct Functions - START ================

  def index

	self.merchants_index_preliminary_actions
		
	@sms_leads,@all_time_leads = Sms.get_sms_leads(0,Date.today.year,@vendor_id)

	@leads = @sms_leads.paginate(:per_page => 10, :page => params[:page])

	@total_price=@sms_leads.collect(&:price).sum.to_i

        @all_time_price=@all_time_leads.collect(&:price).sum.to_i

	@vendor_subscribed_date = VendorsList.where("vendor_id = ?",@vendor_id).select("subscribed_date").map{|i| [i.subscribed_date.strftime("%d-%m-%Y")]}.flatten.join

	  @count=Sms.where("vendor_id = ?",@vendor_id).count

	  @current_count=Sms.where("vendor_id = ? AND YEAR(created_at)=?",@vendor_id,Date.today.year).count

  end

  def obtain_leads
  	
	@chosen_month = params[:month]

	@chosen_year = params[:year]

	@vendor_id = params[:vendor_id]

	@sms_leads,@all_time_leads = Sms.get_sms_leads(@chosen_month,@chosen_year,@vendor_id)

	@leads = @sms_leads.paginate(:per_page => 10, :page => params[:page])

	@total_price=@sms_leads.collect(&:price).sum.to_i

        @all_time_price=@all_time_leads.collect(&:price).sum.to_i

	@vendor_subscribed_date = VendorsList.where("vendor_id = ?",@vendor_id).select("subscribed_date").map{|i| [i.subscribed_date.strftime("%d-%m-%Y")]}.flatten.join

	if(@chosen_month.to_i!=0 && @chosen_year.to_i!=0 && !@vendor_id.nil?)

		@current_count=Sms.where("vendor_id = ? AND MONTH(created_at)=? AND YEAR(created_at)=?",@vendor_id,@chosen_month.to_i,@chosen_year.to_i).count

	elsif (@chosen_year.to_i!=0 && !@vendor_id.nil?)
	
		@current_count=Sms.where("vendor_id = ? AND YEAR(created_at)=?",@vendor_id,@chosen_year.to_i).count

	else
		
		@current_count=Sms.where("vendor_id = ?",@vendor_id).count

	end

	@count=Sms.where("vendor_id = ?",@vendor_id).count

	render :partial => ("merchants_express_interest/leads")

  end

#================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================


  def merchants_index_preliminary_actions

      # This variable is set to make the tab highlighted when its clicked.
      @from = "expressinterest"

      # This method is called from application_controller, this will set the logged_in_login_name instance variable which will always hold the login_name using which the merchant authenticated.
      set_logged_in_merchant

      if (params[:vendor_id].nil?)
      #This method is called from the same file to set the type, vendor and vendor_id instance variables from the current_merchant method called from application_controller which creates a current_merchant instance variable based on the vendor_id mapped to the current login_name and password.
        set_type_vendor_vendor_id

      else
        #This method is called from the same file to set the type, vendor and vendor_id instance variables from the vendor_id chosen by a default vendor from the select drop down menu.
        set_type_vendor_vendor_id(params[:vendor_id].to_i)

      end

      # This method is called from the same file to set the branches select drop down which will display the list of branches for the current vendor.
      set_branches(@vendor.first.vendor_name)

      # The model_name instance variable will be set by this method from the current_merchant instance variable
      self.set_model_name

	if(!session[:notifications_count].nil?)
		title = "CrawlFish - Merchant Login - Leads through Express Interest"
		get_vendor_coupons_count(@vendor_id.to_i,title)
	else
		@meta_merchant_login_title = 'CrawlFish - Merchant Login - Leads through Express Interest'
	end

  end

  def set_model_name

    @model_name = @current_merchant.table_name.camelize

  end

#================ Auxillary Functions - END ================

end
