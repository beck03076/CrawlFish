class MerchantsController < ApplicationController
before_filter :set_city
layout false

  def home

    merchants_home_preliminary_actions

  end

  def index

    merchants_index_preliminary_actions
	  render ('merchants/index')

  end

  def create

   	    user = Merchants.authenticate(params[:merchants])

	    if user
	      puts "OK"
	      session[:merchant_id] = user.merchant_id
              session[:merchant_login_name] = user.login_name
	      session[:merchant_vendor_id]= user.vendor_id
	      session[:notice] = nil
	      session[:notifications_count] = user.vendor_id
	      @which_merchant_page = "login"
	      self.write_login_entry_in_file(session[:merchant_id], session[:merchant_vendor_id],session[:merchant_login_name])
	      redirect_to :controller => "merchants_dashboard", :action => "index"
	    else
	      puts "CANCEL"
	      @message = "Invalid user name or password"
	      merchants_home_preliminary_actions
	      render ('merchants/home')
	    end

  end

  def write_login_entry_in_file(merchantId,vendorId,loginName)
 	
	if(!File.exist?("public/merchants_logs/"+Date.today.to_s+"/"))
	
		FileUtils.mkdir_p("public/merchants_logs/"+Date.today.to_s+"/")

    	end
	puts "inside function to write an entry"
        if (@which_merchant_page.nil?)
		@which_merchant_page = "undefined"	
        end


	if (!(merchantId.nil?) && !(vendorId.nil?) && !(loginName.nil?))

      		if(File.exist?("public/merchants_logs/"+Date.today.to_s+"/"+loginName+'.dat'))
	    		File.open("public/merchants_logs/"+Date.today.to_s+"/"+loginName+'.dat', 'a') {|f| f.write( Time.new.to_s + "|" + merchantId.to_s+"|"+vendorId.to_s+"|"+loginName.to_s+ "|" + @which_merchant_page + "\n") }
    		else
    	    		File.open("public/merchants_logs/"+Date.today.to_s+"/"+loginName+'.dat', 'a') do |f|
		 	f.write(Time.new.to_s + "|" + merchantId.to_s+"|"+vendorId.to_s+"|"+loginName.to_s+ "|" + @which_merchant_page + "\n")
	    		end
    		end
	end
  end

  def destroy

    @which_merchant_page = "logout"
    self.write_login_entry_in_file(session[:merchant_id], session[:merchant_vendor_id],session[:merchant_login_name])
    session[:merchant_id] = nil
    session[:merchant_login_name] = nil
    session[:merchant_vendor_id]= nil
    @message = "Logged out!"
    merchants_home_preliminary_actions
    render ('merchants/home')

  end


end

