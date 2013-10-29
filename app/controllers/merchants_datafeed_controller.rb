class MerchantsDatafeedController < ApplicationController

   before_filter :login_required , :set_cache_buster

# functions defined after this section are direct
#================ Direct Functions - START ================

  def index

     self.datafeed_index_preliminary_actions

     render ("merchants_datafeed/upload")

  end


  def upload

    self.datafeed_index_preliminary_actions

    if !(params[:upload].nil?)

        result = General.data_file_upload(params[:upload],@current_merchant.table_name)

        @fileName = result[0]

        @fileSize = result[1]

        @message = "Thanks for uploading your data feed with us. Your data will reflect in CrawlFish in 24 hours.In case of any queries,contact us @ business{@}thecrawlfish.com"

        @success = 1

    else

        @message = "Please browse and select a file to upload!"

        @success = 0

    end

    render ("merchants_datafeed/upload_success")

  end

  #================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

   def datafeed_index_preliminary_actions

       # This variable is set to make the tab highlighted when its clicked.
      @from = "datafeed"

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

  end

  #================ Auxillary Functions - END ================

end

