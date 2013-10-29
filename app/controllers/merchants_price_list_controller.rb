class MerchantsPriceListController < ApplicationController
  
   before_filter :login_required , :set_cache_buster

   respond_to :html, :js

# functions defined after this section are direct
#================ Direct Functions - START ================

  def index

	  self.merchants_index_preliminary_actions
	  self.set_vendor_products
	  self.set_flash
  end

  def brand_paginate

    puts"========INSIDE brand_paginate============"

    @merchant_selected_brand = params[:selected_brand].to_s if params[:selected_brand]

    puts @merchant_selected_brand

    @current_merchant = current_merchant

    @vendor_id = @current_merchant.vendor_id

    @type = @current_merchant.business_type

    @model_name = @current_merchant.table_name.camelize

    if @merchant_selected_brand.nil?

	@uniq_products = @model_name.constantize.select('DISTINCT product_name,product_price').all
    
    elsif @merchant_selected_brand=="All Brands"

	@uniq_products = @model_name.constantize.select('DISTINCT product_name,product_price').all

    else

	@uniq_products = @model_name.constantize.select('DISTINCT product_name,product_price').where('product_identifier1=?',@merchant_selected_brand).all

    end

    if @uniq_products.count > 20

    	uniq_products_count = @uniq_products.count
    	uniq_products_first_half_count=(@uniq_products.count)/2
    	uniq_products_second_half_count=uniq_products_count-uniq_products_first_half_count

	if @merchant_selected_brand.nil?

	    	@uniq_products_first_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(0).limit(uniq_products_first_half_count)
	    	@uniq_products_second_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(uniq_products_second_half_count).limit(uniq_products_count-uniq_products_first_half_count)
		self.set_price_list_details('All Brands',@vendor_id)

	elsif @merchant_selected_brand=="All Brands"

		@uniq_products_first_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(0).limit(uniq_products_first_half_count)
	    	@uniq_products_second_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(uniq_products_second_half_count).limit(uniq_products_count-uniq_products_first_half_count)
		self.set_price_list_details('All Brands',@vendor_id)
	

	else
		@uniq_products_first_half=@model_name.constantize.select('DISTINCT product_name,product_price').where('product_identifier1=?',@merchant_selected_brand).offset(0).limit(uniq_products_first_half_count)
	    	@uniq_products_second_half=@model_name.constantize.select('DISTINCT product_name,product_price').where('product_identifier1=?',@merchant_selected_brand).offset(uniq_products_second_half_count).limit(uniq_products_count-uniq_products_first_half_count)
		self.set_price_list_details(@merchant_selected_brand,@vendor_id)
	
	end
    else

	if @merchant_selected_brand.nil?

		self.set_price_list_details('All Brands',@vendor_id)

	elsif @merchant_selected_brand=="All Brands"

		self.set_price_list_details('All Brands',@vendor_id)

	else

		self.set_price_list_details(@merchant_selected_brand,@vendor_id)

	end

    end

    render :partial => ("merchants_price_list/products")

  end

  
  def edit

     self.set_type_model_name

     @part1_product = @model_name.constantize.where(:product_name => params[:part1_product_name].to_s).first

     @price_list_product = LocalPriceListProducts.new

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params

  end

  
 def update

     self.merchants_index_preliminary_actions

     @price_list_product = LocalPriceListProducts.new(params[:local_price_list_products])

     @price_list_product.vendor_id = @current_merchant.vendor_id

     @price_list_product.action = params[:merchant_action]

     if @price_list_product.vendor_id.nil?
	@price_list_product.vendor_id = 0
     end

     if @price_list_product.product_price.nil?
	@price_list_product.product_price = 0
     end

     if @price_list_product.save

        redirect_to :controller => 'merchants_price_list', :action => 'index' ,:flash => "edit_success"

      else

        redirect_to :controller => 'merchants_price_list', :action => 'index' ,:flash => "edit_close"

      end

	TestMailer.after_edit_local_price_list_products.deliver

  end

 
  def delete

    self.set_type

    @price_list_product = LocalPriceListProducts.new

  end

 
  def destroy

     self.merchants_index_preliminary_actions

     @part1_product = @model_name.constantize.where(:product_name => params[:part1_product_name].to_s).first

     @price_list_product = LocalPriceListProducts.new

     self.set_merchants_product_similar_columns

     self.set_merchants_product_from_params

     if @price_list_product.vendor_id.nil?
	@price_list_product.vendor_id = 0
     end

     if @price_list_product.product_price.nil?
	@price_list_product.product_price = 0
     end

     if @price_list_product.save
	
	redirect_to :controller => 'merchants_price_list', :action => 'index' ,:flash => "delete_success"

     else

	redirect_to :controller => 'merchants_price_list', :action => 'index' ,:flash => "delete_close"

    end

	TestMailer.after_delete_local_price_list_products.deliver
  end


#================ Direct Functions - END ================

# functions defined after this section are auxillary
#================ Auxillary Functions - START ================


  def merchants_index_preliminary_actions

      # This variable is set to make the tab highlighted when its clicked.
      @from = "pricelist"

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
		title = "CrawlFish - Merchant Login - Price List"
		get_vendor_coupons_count(@vendor_id.to_i,title)
	else
		@meta_merchant_login_title = 'CrawlFish - Merchant Login - Price List'
	end

  end

 
  def set_model_name

    @model_name = @current_merchant.table_name.camelize

    @price_list_options = @model_name.constantize.select('DISTINCT product_identifier1').all.collect {|p| [p.product_identifier1] }.unshift(["All Brands"])

  end

 
  def set_vendor_products

    @uniq_products = @model_name.constantize.select('DISTINCT product_name,product_price').all

    if @uniq_products.count > 20

    	uniq_products_count = @uniq_products.count
    	uniq_products_first_half_count=(@uniq_products.count)/2
    	uniq_products_second_half_count=uniq_products_count-uniq_products_first_half_count
    	@uniq_products_first_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(0).limit(uniq_products_first_half_count)
    	@uniq_products_second_half=@model_name.constantize.select('DISTINCT product_name,product_price').offset(uniq_products_second_half_count).limit(uniq_products_count-uniq_products_first_half_count)

    end

    @vendor = VendorsList.where(:vendor_id => @vendor_id)

    self.set_price_list_details('All Brands',@vendor_id)

  end

  
  def set_price_list_details(brand_name,vendor_id)
	
	if(!vendor_id.nil?)
	
		if(brand_name=='All Brands')

		@price_list_details=LocalPriceListDetails.select('brand_name,brand_logo,distributor_name').where('vendor_id=?',vendor_id).all

		else

		@price_list_details=LocalPriceListDetails.select('brand_name,brand_logo,distributor_name').where('vendor_id=? AND brand_name=?',vendor_id,brand_name).all

		end

	end	
  end

  def set_merchants_product_similar_columns

     @price_list_product.product_name = @part1_product.product_name
     @price_list_product.product_price = @part1_product.product_price
     @price_list_product.vendor_id = @current_merchant.vendor_id

  end


  def set_merchants_product_from_params

     @price_list_product.action = params[:merchant_action]

  end

  
  def set_type_model_name

    current_merchant

    @type = @current_merchant.business_type

    @model_name = @current_merchant.table_name.camelize

  end

 
  def set_type

    current_merchant

    @type = @current_merchant.business_type

  end

 
  def set_flash

    if !params[:flash].nil?

      @flash = params[:flash].to_s

    else

      @flash = nil

    end

  end
#================ Auxillary Functions - END ================

end
