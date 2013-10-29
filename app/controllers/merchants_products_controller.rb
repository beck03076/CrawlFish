class MerchantsProductsController < ApplicationController

   before_filter :login_required , :set_cache_buster

   respond_to :html, :js

# functions defined after this section are direct
#================ Direct Functions - START ================

   def search

     self.merchants_index_preliminary_actions

     self.set_searched_products

   end

   def index

    self.set_flash

    self.merchants_index_preliminary_actions

    self.set_vendor_products

     respond_with

   end

   def new

     self.merchants_index_preliminary_actions

     self.set_type_vendor

          if @type == "local"

            @merchants_product = LocalMerchantProducts.new
            @merchants_product.product_delivery_cost = ""

          elsif @type == "online"

            @merchants_product = OnlineMerchantProducts.new
            @merchants_product.product_shipping_cost = ""

          end

  end

  def create

    self.merchants_index_preliminary_actions

    if @type == "local"

      @merchants_product = LocalMerchantProducts.new(params[:local_merchant_products])


    elsif @type == "online"

      @merchants_product = OnlineMerchantProducts.new(params[:online_merchant_products])

    end

    @merchants_product.reason = ""
    @merchants_product.validity = ""
    @merchants_product.configured_by = ""
    @merchants_product.vendor_id = @vendor_id
    @merchants_product.vendor_table_name = to_u(@model_name)
    @merchants_product.action = params[:merchant_action]
    @merchants_product.part1_product_id = 0 # since part_product_id cannot be null, assigning 0

    if @merchants_product.save

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "create_success"

    else

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "create_close"

    end

   TestMailer.after_create_local_merchant_products.deliver

  end


  def edit

     self.set_type_model_name

     @part1_product = @model_name.constantize.where(:product_id => params[:part1_product_id].to_i).first

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new
       @merchants_product.product_delivery = @part1_product.product_delivery
       @merchants_product.product_delivery_time = @part1_product.product_delivery_time
       @merchants_product.product_delivery_cost = @part1_product.product_delivery_cost

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new
       @merchants_product.product_redirect_url = @part1_product.product_redirect_url
       @merchants_product.product_shipping_time = @part1_product.product_shipping_time
       @merchants_product.product_shipping_cost = @part1_product.product_shipping_cost

     end

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params

  end


  def update

     self.merchants_index_preliminary_actions

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new(params[:local_merchant_products])

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new(params[:online_merchant_products])

     end

     @merchants_product.part1_product_id = params[:part1_product_id]
     @merchants_product.vendor_id = @vendor_id
     @merchants_product.vendor_table_name = to_u(@model_name)
     @merchants_product.action = params[:merchant_action]
     @merchants_product.product_sub_category = params[:product_sub_category]
     @merchants_product.reason = params[:reason]
     @merchants_product.validity = params[:validity]
     @merchants_product.configured_by = params[:configured_by]
     @merchants_product.product_image_url = params[:product_image_url]


     if @merchants_product.save

        redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "edit_success"

     else

        redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "edit_close"

     end

	TestMailer.after_edit_local_merchant_products.deliver
      
  end


  def delete

    self.set_type

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new

     end

  end


  def destroy

     self.merchants_index_preliminary_actions

     @part1_product = @model_name.constantize.where(:product_id => params[:part1_product_id]).first

     if @type == "local"

       @merchants_product = LocalMerchantProducts.new
       @merchants_product.product_delivery = @part1_product.product_delivery
       @merchants_product.product_delivery_time = @part1_product.product_delivery_time
       @merchants_product.product_delivery_cost = @part1_product.product_delivery_cost

     elsif @type == "online"

       @merchants_product = OnlineMerchantProducts.new
       @merchants_product.product_redirect_url = @part1_product.product_redirect_url
       @merchants_product.product_shipping_time = @part1_product.product_shipping_time
       @merchants_product.product_shipping_cost = @part1_product.product_shipping_cost

     end

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params


     if @merchants_product.save

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "delete_success"

    else

      redirect_to :controller => 'merchants_products', :action => 'index' ,:flash => "delete_close"

    end

    TestMailer.after_delete_local_merchant_products.deliver

  end
#================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================


  def merchants_index_preliminary_actions

      # This variable is set to make the tab highlighted when its clicked.
      @from = "catalogue"

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
		title = "CrawlFish - Merchant Login - Catalogue"
		get_vendor_coupons_count(@vendor_id.to_i,title)
	else
		@meta_merchant_login_title = 'CrawlFish - Merchant Login - Catalogue'
	end

  end


  def set_flash

    if !params[:flash].nil?

      @flash = params[:flash].to_s

    else

      @flash = nil

    end

  end

  def set_searched_products

    @products =  @model_name.constantize.where('product_name like ?',"%#{params[:query]}%").paginate(:per_page => 5, :page => params[:page] || nil)

  end

  def set_vendor_products

    @products = @model_name.constantize.all.paginate(:per_page => 10 , :page => params[:page])

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

  end

  def set_merchants_product_similar_columns

     @merchants_product.product_name = @part1_product.product_name
     @merchants_product.product_image_url = @part1_product.product_image_url
     @merchants_product.product_category = @part1_product.product_category
     @merchants_product.product_sub_category = @part1_product.product_sub_category
     @merchants_product.product_identifier1 = @part1_product.product_identifier1
     @merchants_product.product_identifier2 = @part1_product.product_identifier2
     @merchants_product.product_price = @part1_product.product_price
     @merchants_product.product_availability = @part1_product.product_availability
     @merchants_product.product_special_offers = @part1_product.product_special_offers
     @merchants_product.product_warranty = @part1_product.product_warranty
     @merchants_product.reason = @part1_product.reason
     @merchants_product.validity = @part1_product.validity
     @merchants_product.configured_by = @part1_product.configured_by
     @merchants_product.part1_product_id = @part1_product.product_id
     @merchants_product.vendor_id = @vendor_id
     @merchants_product.vendor_table_name = to_u(@model_name)

  end

  def set_merchants_product_from_params

     @merchants_product.action = params[:merchant_action]

  end

  def set_type

    current_merchant

    @type = @current_merchant.business_type

  end

  def set_type_model_name

    current_merchant

    @type = @current_merchant.business_type

    @model_name = @current_merchant.table_name.camelize

  end

  def set_type_vendor

    current_merchant

    @type = @current_merchant.business_type

    @vendor_id = @current_merchant.vendor_id

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

  end

  def set_model_name

    @model_name = @current_merchant.table_name.camelize

  end


#================ Auxillary Functions - END ================


end

