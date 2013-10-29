class AndGoDashboardController < ApplicationController

   before_filter :and_go_login_required , :set_cache_buster

   respond_to :html, :js

   include ActionView::Helpers::TextHelper

   include ActionView::Helpers::NumberHelper

  def index

    	@and_go_user_name = session[:login_name]

	@and_go_id = session[:and_go_id]

	@from="andgo"

	@sub_categories = Subcategories.select("category_name,sub_category_id").all

	if  !params[:andgo_sub_category_id].nil?

        	@sub_category_id = params[:andgo_sub_category_id].to_i

	else

		@sub_category_id = 1
	end

  end


  def product_search

    list = []

    search_key = params[:term].to_s

    search_key = '%' + search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq.join(" ") + '%'

    titles = ProductsFilterCollections.get_names_for_quick_search(search_key).flatten

    unique_titles=titles.uniq    

    unique_titles.first(4).each {|i| list << {"label" => i}}

     respond_to do |format|

      format.json {render :json => list.to_json , :layout => false}

    end

  end

  def city_search

        list = []

	search_key = params[:term].to_s

	search_key = '%' + search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq.join(" ") + '%'
	
	cities=Cities.select("DISTINCT(city_name)").where("city_name like ?",search_key).map{|i| [i.city_name.titlecase]}.flatten

 	cities.first(4).each {|i| list << {"label" => i}}

    	respond_to do |format|

      		format.json {render :json => list.to_json , :layout => false}

    	end

  end

  def area_search

        list = []

	search_key = params[:term].to_s

	search_key = '%' + search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq.join(" ") + '%'
	
	branches=Branches.select("DISTINCT(branch_name)").where("branch_name like ?",search_key).map{|i| [i.branch_name.titlecase]}.flatten

 	branches.first(4).each {|i| list << {"label" => i}}

    	respond_to do |format|

      		format.json {render :json => list.to_json , :layout => false}

    	end

  end

  def get_vendor_details

	self.set_vendor_details_variables

	self.get_product_details(@query,@sub_category_id)
	
	self.get_city_area_details(@city,@area)

	@product_name = @query

	@no_price_flag = 0

	if( @city_id.to_i==0 || @product_id.nil? || (@product_id.to_i==0))
	
		if(@area_id.to_i==0 && @city_id.to_i==0)
			@record=nil
		elsif(@area_id.to_i==0 && @city_id.to_i!=0)
			@record = VendorsList.where("city_name = ?",@city)
		elsif(@area_id.to_i!=0 && @city_id.to_i!=0)
			@record = VendorsList.where("city_name = ? AND branch_name = ?",@city,@area)
		end

		@no_price_flag = 1

	else
		@record = LocalGridDetails.get_grid(@product_id,@sub_category_id,0,@area_id)
		@no_price_flag = 0
	end

	#obtain only the vendor_ids
	self.set_vendor_ids

	#sorting the result set
	if(@order == "vendor_alias_name ASC" || @order == "vendor_alias_name DESC" || @order == "trial_flag ASC" || @order == "trial_flag DESC" || @order == "price ASC" || @order == "price DESC")

		@vendor_details = @record.order(@order)

	elsif(@order == "leads ASC")
	
		@vendor_coupons = VendorCoupons.where("MONTH(created_at) = ? AND YEAR(created_at) = ? AND vendor_id IN (?)",Date.today.month,Date.today.year,@vendor_ids).select("vendor_id").group("vendor_id")

		@asc_vendor_coupons = @vendor_coupons.order("count(*) ASC")

		@vendor_details=[]

		for element1 in @asc_vendor_coupons
		for element2 in @record
			if(element1.vendor_id == element2.vendor_id)
				@vendor_details << element2
			end
		end
		end
					
	elsif(@order == "leads DESC")
		
		@vendor_coupons = VendorCoupons.where("MONTH(created_at) = ? AND YEAR(created_at) = ? AND vendor_id IN (?)",Date.today.month,Date.today.year,@vendor_ids).select("vendor_id").group("vendor_id")

		@desc_vendor_coupons = @vendor_coupons.order("count(*) DESC")

		@vendor_details=[]

		for element1 in @desc_vendor_coupons
		for element2 in @record
			if(element1.vendor_id == element2.vendor_id)
				@vendor_details << element2
			end
		end
		end

	elsif(@order == "")
	
		@vendor_details = @record

	end

        render :partial => "and_go_dashboard/vendor_details" 

  end

  def submit_vendor_request

	self.set_vendor_request_variables

	if(@product_id.to_i != 0)
		self.get_unique_id
	else
		@unique_id = 0
	end

	if (@actual_price.to_i == 0)
		self.get_product_price
	else
		self.set_product_price
	end

	self.generate_coupon_code(@product_id)

        self.send_coupon_code_mailer(@product_id,@product_name,@sub_category_id,@vendor_id,@coupon_code,@actual_price)

	render :nothing => true

  end


  def set_vendor_request_variables

	if !params[:sub_category_id].nil?
	   	@sub_category_id = params[:sub_category_id].to_i
	else
		@sub_category_id = 0
	end

	if !params[:product_id].nil?
	   	@product_id = params[:product_id].to_i
	else
		@product_id = 0
	end

	if !params[:mobile_number].nil?
	   	@mobile_number = params[:mobile_number].to_i
	else
		@mobile_number = 0
	end

	if !params[:vendor_id].nil?
	   	@vendor_id = params[:vendor_id].to_i
	else
		@vendor_id = 0
	end

	if !params[:price].nil?
	   	@actual_price = params[:price].to_i
	else
		@actual_price = 0
	end

	if !params[:product_name].nil?
	   	@product_name = params[:product_name].to_s
	else
		@product_name = 0
	end

	if !params[:vendor_phone_number].nil?
	   	@vendor_phone_number = params[:vendor_phone_number].to_s
	else
		@vendor_phone_number = 0
	end

  end

  def set_vendor_details_variables

	if !params[:sub_category_id].nil?
	   	@sub_category_id = params[:sub_category_id].to_i
	else
		@sub_category_id = 1
	end

	if !params[:query].nil?
	   	@query = params[:query].to_s
	else
		@query = ""
	end

	if !params[:mobile_number].nil?
	   	@mobile_number = params[:mobile_number].to_i
	else
		@mobile_number = 0
	end

	if !params[:city].nil?
	   	@city = params[:city].to_s
	else
		@city = ""
	end

	if !params[:area].nil?
	   	@area = params[:area].to_s
	else
		@area = ""
	end

	if !params[:order].nil?
	   	@order = params[:order].to_s
	else
		@order = ""
	end
  end


  def get_product_details(query,sub_category_id)
	
	@product_id = 0

	sub_category = (Subcategories.what_is_my_name(sub_category_id.to_i).flatten.join).chomp.downcase

	get_product_id(query,sub_category)

  end


  def get_product_id(query,sub_category)

	if(sub_category == "mobiles_lists")
	
		product = MobilesLists.where("mobile_name =?",query).select("mobiles_lists.*").first
		if(!product.nil?)
			@product_id = product.mobiles_list_id.to_i
		end

	elsif(sub_category == "laptops_lists")
		
		product = LaptopsLists.where("laptop_name =?",query).select("laptops_lists.*").first
		if(!product.nil?)
			@product_id = product.laptops_list_id.to_i
		end

	elsif(sub_category == "desktops_lists")
		
		product = DesktopsLists.where("desktop_name =?",query).select("desktops_lists.*").first
		if(!product.nil?)
			@product_id = product.desktops_list_id.to_i
		end
	
	elsif(sub_category == "external_hdds_lists")

		product = ExternalHddsLists.where("external_hdd_name =?",query).select("external_hdds_lists.*").first
		if(!product.nil?)
			@product_id = product.external_hdds_list_id.to_i
		end

	elsif(sub_category == "printers_lists")

		product = PrintersLists.where("printer_name =?",query).select("printers_lists.*").first
		if(!product.nil?)
			@product_id = product.printers_list_id.to_i
		end

	elsif(sub_category == "routers_lists")

		product = RoutersLists.where("router_name =?",query).select("routers_lists.*").first
		if(!product.nil?)
			@product_id = product.routers_list_id.to_i
		end

	elsif(sub_category == "mouses_lists")

		product = MousesLists.where("mouse_name =?",query).select("mouses_lists.*").first
		if(!product.nil?)
			@product_id = product.mouses_list_id.to_i
		end
	
	elsif(sub_category == "keyboards_lists")

		product = KeyboardsLists.where("keyboard_name =?",query).select("keyboards_lists.*").first
		if(!product.nil?)
			@product_id = product.keyboards_list_id.to_i
		end
	
	elsif(sub_category == "speakers_lists")

		product = SpeakersLists.where("speaker_name =?",query).select("speakers_lists.*").first
		if(!product.nil?)
			@product_id = product.speakers_list_id.to_i
		end

	elsif(sub_category == "memory_cards_lists")

		product = MemoryCardsLists.where("memory_card_name =?",query).select("memory_cards_lists.*").first
		if(!product.nil?)
			@product_id = product.memory_cards_list_id.to_i
		end

	elsif(sub_category == "pendrives_lists")

		product = PendrivesLists.where("pendrive_name =?",query).select("pendrives_lists.*").first
		if(!product.nil?)
			@product_id = product.pendrives_list_id.to_i
		end

	elsif(sub_category == "headphones_lists")

		product = HeadphonesLists.where("headphone_name =?",query).select("headphones_lists.*").first
		if(!product.nil?)
			@product_id = product.headphones_list_id.to_i
		end

	elsif(sub_category == "headsets_lists")

		product = HeadsetsLists.where("headset_name =?",query).select("headsets_lists.*").first
		if(!product.nil?)
			@product_id = product.headsets_list_id.to_i
		end

	elsif(sub_category == "tablets_lists")

		product = TabletsLists.where("tablet_name =?",query).select("tablets_lists.*").first
		if(!product.nil?)
			@product_id = product.tablets_list_id.to_i
		end
	end

  end


  def get_city_area_details(city,area)
	
	city = (Cities.where("city_name = ?",city).select("city_id").first)
	
	if(!city.nil?)	
		@city_id = city.city_id
	else
		@city_id = 0
	end

	if(@city_id.to_i == 0)
		@area_id = 0	
	else
		if(area.length <= 1)
			@area_id = 0
		elsif 
			area= Branches.where("branch_name = ? AND city_id = ?",area.gsub(/[^A-Za-z0-9]/,""),@city_id).select("branch_id").first
			@area_id = area.branch_id.to_i
		end
	end

  end


  def set_vendor_ids

	#get vendor ids
	@vendor_ids = []

	if(!@record.nil?)
		@record.each do |i|
			@vendor_ids << i.vendor_id
		end
	end

  end

  def get_unique_id

	@unique_id = 0

	id = LinkProductsListsVendors.where("vendor_id = (?) AND products_list_id = (?) AND sub_category_id = (?) AND availability_id IN (2,4)",@vendor_id,@product_id,@sub_category_id).select("unique_id").first
	
	@unique_id = id.unique_id
	
  end	


  def get_product_price

	if(@product_id.to_i != 0)
		price_details = LocalGridDetails.where("unique_id = (?)",@unique_id.to_i).select("price").first

		@actual_price = price_details.price
	else
		@actual_price = 0
	end

  end


  def set_product_price

	if(!@vendor_id.nil?)

		details = VendorsList.where("vendor_id = ?",@vendor_id).select("city_name,branch_name,vendor_name").first
		city_name = details.city_name.chomp.downcase
		branch_name = details.branch_name.chomp.downcase
		vendor_name = details.vendor_name.chomp.downcase

		table_name = "Local" + city_name.capitalize + branch_name.capitalize + vendor_name.capitalize + "Products"

		sub_category = (Subcategories.what_is_my_name(@sub_category_id.to_i).flatten.join).chomp.downcase
		
		self.set_price(@product_id,sub_category,table_name)

	end
  end


  def set_price(product_id,sub_category,table_name)

	if(sub_category == "mobiles_lists")

		product_details = MobilesLists.where("mobiles_list_id = ?",product_id).select("mobile_name,mobile_color").first
		price_details = table_name.constantize.find_or_initialize_by_product_name_and_product_identifier2(product_details.mobile_name,product_details.mobile_color)
		price_details.product_price = @actual_price
		price_details.save
	
	elsif(sub_category == "laptops_lists")

		product_details = LaptopsLists.where("laptops_list_id = ?",product_id).select("laptop_part_no").first
		price_details =	table_name.constantize.find_or_initialize_by_product_identifier2(product_details.laptop_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "desktops_lists")

		product_details = DesktopsLists.where("desktops_list_id = ?",product_id).select("desktop_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.desktop_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "external_hdds_lists")

		product_details = ExternalHddsLists.where("external_hdds_list_id = ?",product_id).select("external_hdd_part_no").first	
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.external_hdd_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "printers_lists")

		product_details = PrintersLists.where("printers_list_id = ?",product_id).select("printer_model_name").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.printer_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "routers_lists")

		product_details = RoutersLists.where("routers_list_id = ?",product_id).select("router_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.router_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "mouses_lists")

		product_details = MousesLists.where("mouses_list_id = ?",product_id).select("mouse_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.mouse_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "keyboards_lists")

		product_details = KeyboardsLists.where("keyboards_list_id = ?",product_id).select("keyboard_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.keyboard_part_no)
		price_details.product_price = @actual_price
		price_details.save
	
	elsif(sub_category == "speakers_lists")

		product_details = SpeakersLists.where("speakers_list_id = ?",product_id).select("speaker_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.speaker_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "memory_cards_lists")

		product_details = MemoryCardsLists.where("memory_cards_list_id = ?",product_id).select("memory_card_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.memory_card_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "pendrives_lists")

		product_details = PendrivesLists.where("pendrives_list_id = ?",product_id).select("pendrive_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.pendrive_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "headphones_lists")

		product_details = HeadphonesLists.where("headphones_list_id = ?",product_id).select("headphone_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.headphone_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "headsets_lists")

		product_details = HeadsetsLists.where("headsets_list_id = ?",product_id).select("headset_part_no").first	
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.headset_part_no)
		price_details.product_price = @actual_price
		price_details.save

	elsif(sub_category == "tablets_lists")

		product_details = TabletsLists.where("tablets_list_id = ?",product_id).select("tablet_part_no").first
		price_details = table_name.constantize.find_or_initialize_by_product_identifier2(product_details.tablet_part_no)
		price_details.product_price = @actual_price
		price_details.save

	end

  end


  def generate_coupon_code(product_id)

 	if(@coupon_code.nil?)

		if(product_id==0)
			generated_code,is_existing = AndGoCoupons.generate_andgo_coupon_code(@vendor_id,@product_name,@sub_category_id,@mobile_number,@actual_price)
		else
			generated_code,is_existing = VendorCoupons.generate_coupon_code(@vendor_id,@unique_id,@sub_category_id,@mobile_number)
		end

		@coupon_code = generated_code

		@existing_coupon_code_flag = is_existing

    	else

      		@coupon_code = "nocode"

   	 end

  end


  def send_coupon_code_mailer(product_id,product_id_name,sub_category_id,vendor_id,coupon_code,product_price)

	if(product_id == 0)

		product_details = product_id_name.to_s

		customer_details = AndGoCoupons.where("coupon_code = ?",coupon_code).select("customer_phone_number").first

		product_name = truncate(product_details,:length=>33).gsub('...','').strip

		product_identifier = "no"

	else

		sub_category = (Subcategories.what_is_my_name(sub_category_id.to_i).flatten.join).chomp.downcase

		product_details,product_name,product_identifier = get_product_details_for_coupons(product_id,sub_category)
	
		customer_details = VendorCoupons.where("coupon_code = ?",coupon_code).select("customer_phone_number").first	

	end

	vendor_details = VendorsDetails.where("vendor_id = ?",vendor_id).first

	#Generate Coupon Code - Customer SMS Details
	vendor_info = truncate(vendor_details.vendor_name.strip+", "+vendor_details.vendor_branch.strip,:length=>38).gsub('...','').strip

	if(@vendor_phone_number.to_i == 0)
		vendor_phone_no = vendor_details.vendor_phone
	else
		vendor_phone_no = @vendor_phone_number
	end

	#Generate Coupon Code - Customer SMS text
	@customer_message = "Dear Customer, Your request to buy "+product_name+" from "+vendor_info+", ph:"+vendor_phone_no+" is processed CouponCode:"+coupon_code.upcase+" Rs."+number_with_delimiter(product_price.to_i)+"/-"

	#Generate Coupon Code - Vendor SMS Details
	customer_phone_no = customer_details.customer_phone_number
	vendor_name = ""
	if vendor_details.vendor_contact_name.mb_chars.length > 10
		vendor_name = "Merchant"
	else
		vendor_name = vendor_details.vendor_contact_name
	end

	#Generate Coupon Code - Vendor SMS text
	@vendor_message = "Dear "+vendor_name+", Received an enquiry from "+customer_phone_no+" for "+product_name+" Rs."+number_with_delimiter(product_price.to_i)+"/- Kindly follow-up. CouponCode:"+coupon_code.upcase+" CrawlFish Support: +919551707070"

	#SMS initialization
	user_name = "transinfinity"
	password = "sector@1"

	@customer_message_url = URI::encode("http://www.smsintegra.com/smsweb/desktop_sms/desktopsms.asp?uid="+user_name+"&pwd="+password+"&mobile=91"+customer_phone_no+"&msg="+@customer_message+"&sid=CRAWLF&dtNow="+Time.new.to_s)

	@vendor_message_url = URI::encode("http://www.smsintegra.com/smsweb/desktop_sms/desktopsms.asp?uid="+user_name+"&pwd="+password+"&mobile=91"+vendor_phone_no+"&msg="+@vendor_message+"&sid=CRAWLF&dtNow="+Time.new.to_s)
	
	#Customer SMS initiation
	#@customer_message_response = open(@customer_message_url).read
	#@customer_message_response_code = @customer_message_response.split("-")[0].strip
	@customer_message_response ="OK"
	@customer_message_response_code="100"
	#Vendor SMS initiation
	#@vendor_message_response = open(@vendor_message_url).read
	#@vendor_message_response_code = @vendor_message_response.split("-")[0].strip
	@vendor_message_response="ok"
	@vendor_message_response_code="100"

	p @customer_message
	p @vendor_message

	if(!product_details.nil? && !customer_details.nil? && !vendor_details.nil?)
	
		#TestMailer.after_generate_coupon_code(product_name,product_identifier,product_price,customer_details.customer_phone_number,coupon_code,vendor_details.vendor_name,vendor_details.vendor_phone,vendor_details.vendor_city,vendor_details.vendor_branch,@customer_message,@customer_message_response,@customer_message_response_code,@vendor_message,@vendor_message_response,@vendor_message_response_code).deliver

	end
 end


 def get_product_details_for_coupons(product_id,sub_category)
	
	if(sub_category == "mobiles_lists")

		product_details = MobilesLists.where("mobiles_list_id = ?",product_id).select("mobile_name,mobile_color").first
		product_name = truncate(product_details.mobile_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.mobile_color
	
	elsif(sub_category == "laptops_lists")

		product_details = LaptopsLists.where("laptops_list_id = ?",product_id).select("laptop_name,laptop_part_no").first
		product_name = truncate(product_details.laptop_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.laptop_part_no

	elsif(sub_category == "desktops_lists")

		product_details = DesktopsLists.where("desktops_list_id = ?",product_id).select("desktop_name,desktop_part_no").first
		product_name = truncate(product_details.desktop_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.desktop_part_no

	elsif(sub_category == "external_hdds_lists")

		product_details = ExternalHddsLists.where("external_hdds_list_id = ?",product_id).select("external_hdd_name,external_hdd_part_no").first
		product_name = truncate(product_details.external_hdd_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.external_hdd_part_no

	elsif(sub_category == "printers_lists")

		product_details = PrintersLists.where("printers_list_id = ?",product_id).select("printer_name,printer_model_name").first
		product_name = truncate(product_details.printer_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.printer_model_name

	elsif(sub_category == "routers_lists")

		product_details = RoutersLists.where("routers_list_id = ?",product_id).select("router_name,router_part_no").first
		product_name = truncate(product_details.router_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.router_part_no

	elsif(sub_category == "mouses_lists")

		product_details = MousesLists.where("mouses_list_id = ?",product_id).select("mouse_name,mouse_part_no").first
		product_name = truncate(product_details.mouse_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.mouse_part_no

	elsif(sub_category == "keyboards_lists")

		product_details = KeyboardsLists.where("keyboards_list_id = ?",product_id).select("keyboard_name,keyboard_part_no").first
		product_name = truncate(product_details.keyboard_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.keyboard_part_no

	elsif(sub_category == "speakers_lists")

		product_details = SpeakersLists.where("speakers_list_id = ?",product_id).select("speaker_name,speaker_part_no").first
		product_name = truncate(product_details.speaker_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.speaker_part_no

	elsif(sub_category == "memory_cards_lists")

		product_details = MemoryCardsLists.where("memory_cards_list_id = ?",product_id).select("memory_card_name,memory_card_part_no").first
		product_name = truncate(product_details.memory_card_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.memory_card_part_no

	elsif(sub_category == "pendrives_lists")

		product_details = PendrivesLists.where("pendrives_list_id = ?",product_id).select("pendrive_name,pendrive_part_no").first
		product_name = truncate(product_details.pendrive_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.pendrive_part_no

	elsif(sub_category == "headphones_lists")

		product_details = HeadphonesLists.where("headphones_list_id = ?",product_id).select("headphone_name,headphone_part_no").first
		product_name = truncate(product_details.headphone_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.headphone_part_no


	elsif(sub_category == "headsets_lists")

		product_details = HeadsetsLists.where("headsets_list_id = ?",product_id).select("headset_name,headset_part_no").first
		product_name = truncate(product_details.headset_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.headset_part_no

	elsif(sub_category == "tablets_lists")

		product_details = TabletsLists.where("tablets_list_id = ?",product_id).select("tablet_name,tablet_part_no").first
		product_name = truncate(product_details.tablet_name,:length=>33).gsub('...','').strip
		product_identifier = product_details.tablet_part_no

	end

	[product_details,product_name,product_identifier]

 end

end
