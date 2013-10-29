class ApplicationController < ActionController::Base

before_filter :set_start_time,:set_city,:help_update_numbers,:set_route,
              :except =>[:grab_price,:update_online_price,:latest_price_send,
                        :get_pattern,:vendor_rating,:vendor_rating_save,
                        :sms,:update_online_grid,:update_local_grid,
                        :open_add_shop,:add_shop,:generate_coupon_code,:pop,
                        :complain,:set_areas,:update_numbers,:viewed]

  def set_start_time
    @start_time = Time.now.usec
    @c_cat = (Subcategories.select("count(*) as i").map &:i)[0]
    @c_prod = (LinkProductsListsVendors.select("COUNT(products_list_id) as i").map &:i)[0]
    @c_vend = (VendorsList.select("count(vendor_id) as i").map &:i)[0]
  end

  protect_from_forgery

  include RubyUtilities

  include SearchModule

  # This line is to include the modules that give access to this class to the net methods to get the IP address
  require 'net/http'

   unless Rails.application.config.consider_all_requests_local

    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

  end
  # This checks if there is a record existing already in the VendorProductTransactionsLogs table, if not creates a record with clicks as 1 or updates the found clicks + 1
  def save_clicks  
    v = VendorProductTransactionsLogs.where(:vendor_id => @vendor_id, 
                                            :product_id => @product_id,
                                            :sub_category_id => @sub_category_id).first
    d = Date.today
    if v.blank?
      VendorProductTransactionsLogs.create(:vendor_id => @vendor_id, 
                                           :product_id => @product_id,
                                           :sub_category_id => @sub_category_id,
                                           :button_clicks_count => 1,
                                           :page_impressions_count => 0,
                                           :log_date => d)

    else
        v.button_clicks_count += 1
        v.save!
    end
  
  end
  # this takes the first param of the request url and sets it on @route variable
  def set_route
    @route = request.fullpath.split("/")[1]
  end
    
  # outputs a msg on the console with decoration
  def say(i)
   puts "\n#############################################################################\n"
   puts i
   puts "#############################################################################\n"
  end
  
  # stands for vendor top, it will randomly select 8 vendors from vendors_lists where top is 1
  def shops_12
             # Fetch random top vendors, order by random, only 8
    @shops_12 = VendorsList.where(:top => 1,:business_type => "local").order('rand()').limit(12)
    @admin_12 = set_admin(@shops_12.map{|i| i.vendor_id})
  end
  
  # stands for popular(products), takes the p_l_id where category is @cat || default and fetching those p_l_id from part-2, Used in the main page
  def pop
    # the home page default active popular menu is mobiles_lists    
    default = "mobiles_lists"
    
    set_url_params
    
    cat = @cat.nil? ? default : @cat  
    id = (cat.chop + "_id").to_sym
    
    set_sub_categories(0,cat)
    
    arr = RubyUtilities.m_columns(@sub_category_name)
    @url = arr[4]
    @name = arr[2]
    # setting the number of shops per category
    @cat_vend = LinkVendorsListsSubCategories.group("sub_category_id").size
    # taking the p_l_id where category is mobile_lists and fetching those p_l_id from part-2
    @pop = cat.camelize.constantize.where(id => Populars.where(:category => cat ).map{|i| i.p_l_id})
    if !@cat.nil?
        @country = "india"
        render :partial => "shared/pop"
    end
  end
  
  # stands for random 7 popular(products), takes the p_l_id where category is @cat || default and fetching those p_l_id from part-2, Used in all pages
  def pop_7
    
    set_url_params
    
    out = []
    # this block sets popular 7 products of current category and takes a random category if category_name is unavailable
    if params[:category_name].nil? # using params[:category_name] and not @category_name because @ is set somewhere 
        out = Subcategories.all.map{|i| [i.sub_category_name,i.category_name] }.sample
    else
       set_sub_categories(@category_name)
       out[0] = @sub_category_name
       out[1] = @category_name
    end
    
    cat = out[0]
    @category_name_7 = out[1]
    
    id = (cat.chop + "_id").to_sym
    temp = cat.split("_")
    temp.pop
    @ft = temp.join("_").chop + "_features"
    
    arr = RubyUtilities.m_columns(cat)
    @url_7 = arr[4]
    @name_7 = arr[2]
   
    # taking the p_l_id where category is mobile_lists and fetching those p_l_id from part-2
    @pop_7 = cat.camelize.constantize.where(id => Populars.where(:category => cat ).map{|i| i.p_l_id})
    
  end
   
  # stands for popular_price_range, select price ranges randomly from models_methods.rb
  def p_p_range  
    @p_p_range = []
    # shuffling sub_categories and taking 7 items and getting the highest in price range to display below
    @sub_categories.shuffle.take(7).each do |i|    
      p = RubyUtilities.m_columns(i.sub_category_name)[9]
      p = p[(p.length/2)]
      @p_p_range << {i.category_name => p}
    end
  end 
     
  # stands for online_shops, select all online shops at cf randomly
  def o_shops 
             # Fetch random 70 areas from branches table
    obj = VendorsList.where(:business_type => "online").order('rand()').limit(20).map{|i| [i.vendor_name,i.vendor_website]}
    @o_shops = obj.each_slice(10).to_a  
  end 
   
  # stands for all areas, it will select 70 areas on a random basis from branches table
  def a_areas 
             # Fetch random 70 areas from branches table
    @a_areas = Branches.order('rand()').limit(120).all.map{|i| i.branch_name}.each_slice(20).to_a  
  end 

  # stands for vendor top, it will randomly select 14 vendors from vendors_lists where top is 1
  def v_top 
             # Fetch random top vendors, order by random, split the array to chunks of 7 sized arrays
    @v_top = VendorsList.where(:top => 1,:business_type => "local").order('rand()').limit(14).map{|i| i.branch_name + "/" + i.vendor_alias_name }.each_slice(7).to_a  
  end
  
  # stands for generic hub, it will randomly select 14 hub areas from branches table
  def g_hub 
             # Fetch random hub areas, order by random, split the array to chunks of 7 sized arrays
    @g_hub = Branches.where(:hub => 'y').order('rand()').limit(14).map{|i| i.branch_name}.each_slice(7).to_a  
  end
   
  def show_shop_page

     set_url_params
     
     @area = @area_names.nil? ? @area : @area_names
         
     @products =  Hash.new{|hash, key| hash[key] = Hash.new}     

     @shop = VendorsList.get_vendor_by_name_branch(url_to_s(@vendor_name),url_to_s(@area)).first
     
     @v_id = @shop.vendor_id
     
     @cat_bran = eval(@shop.cat_bran)
     
     @cat_bran.keys.each do |c|
     
       c_items = RubyUtilities.m_columns(c)
     
       @cats = c + "|" + c_items[2..4].join("|")

       @cat_bran[c].split(",").each do |b|

                @products[@cats][b] = modelize(c).where(c_items[1] => b).order("rand()").limit(10)
            
       end
            
     end
     
  end 
  
  def set_vendor(v,b)
  
      @vendor = VendorsList.where(:vendor_alias_name => url_to_s(v),
                                  :branch_name => url_to_s(b)).first
                                  
      if @vendor.nil?      
        @vendor = VendorsList.where(:vendor_alias_name => url_to_s(v)).first
      end

      @vendor_id = @vendor.vendor_id
      
      @vendor_alias_name = @vendor.vendor_alias_name
      
      @branch_alias_name = @vendor.branch_alias_name
   
  end
  
  def set_current_branch

    @current_branch = Branches.get_current_branch(@vendor_id)

  end
   
  def vendor_rating
  
      set_url_params("area_names,category_name,city,country,identifier,product_name,shop,vendor_id,product_identifier")
      
      @identifier = @identifier.nil? ? @product_identifier : @identifier
      
      @reviews = VendorsRatings.reviews(@vendor_id)
      
      say(@reviews.map{|i|i.rating})
      
      if @reviews.size == 0
      
        m = "Review this vendor and help people!"
      
      else
      
        m = "Listing <b>#{@reviews.size}</b> Reviews ..."
      
      end
      
      @msg = m
      
  end
   
  def set_ratings(v_ids)
  
    hash = {}
  
    VendorsRatings.ratings(v_ids).each {|i| hash[i.vendor_id] = [i.avg.to_f.round(1),i.nos] }
    
    hash
  
  end
  
  def set_clicks_no(v_id)
    
    hash = {}
    
    out = VendorProductTransactionsLogs.get_count_button_clicks(v_id)
    
    if out == 1
       v_id = []
       v_id.each {|i| hash[i] = "N.A" }
        
    else
    
       out.each {|i| hash[i.vendor_id] = i.clicks_no.to_i }
        
    end        
    
    hash
    
  end 
  
  def set_admin(v_id)
  
    hash = {}
  
    VendorsList.get_admin_branch_name(v_id).each {|i| hash[i.vendor_id] = i.adm }
    
    hash
  
  end
   
  def set_url_params(params_list = 0)
  
    if params_list == 0
    
      params_list = params.keys.join(",") 
                           
    end
    
    params_list.split(",").each do |p|
    
       if !params[p.to_sym].nil?
            
         val = params[p.to_sym]
               
         instance_variable_set("@"+p,val)
                            
      end
                  
    end
    
  end 
   
  def render_404(exception)

    @not_found_path = exception.message

    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end

  end

  def render_500(exception)

    @error = exception

    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end

  end

  def set_sub_category_flag

    if !(params[:sub_category_id].to_i == 0)

      @sub_category_flag = params[:sub_category_id].to_i

    else

      @sub_category_flag = nil

    end

  end

  def set_sub_categories(category_name = 0, sub_category_name = 0, sub_category_id = 0)#this will set the @sub_categories variable with all the records in Subcategories table.

    if category_name != 0 && sub_category_name == 0  && sub_category_id == 0

      self.help_set_sub_category("category_name",category_name)

    elsif category_name == 0  && sub_category_name != 0  && sub_category_id == 0

      self.help_set_sub_category("sub_category_name",sub_category_name)

    elsif category_name == 0  && sub_category_name == 0  && sub_category_id != 0

      self.help_set_sub_category("sub_category_id",sub_category_id)

    elsif category_name == 0  && sub_category_name == 0  && sub_category_id == 0

      @sub_categories = Subcategories.all

    end

  end

  def help_set_sub_category(what,value)

      @sub_category = Subcategories.send("find_by_#{what}".to_sym, value)

      @sub_category_name = @sub_category.sub_category_name

      @sub_category_id = @sub_category.sub_category_id

      @category_name = @sub_category.category_name
      
  end

  def set_sub_category_id

    if !(params[:sub_category_id].nil?)

      @sub_category_id = params[:sub_category_id].to_i

    end

  end

  def set_query_as_nil

    params[:query] = nil

  end

  def error_log(error_message,code = 1)

    puts "XXXXXXX==ERROR MESSAGE START==XXXXXXXXX"

    puts "LOGGED MESSAGE : #{error_message}, CODE : #{code}, at #{Time.now}"

    puts "XXXXXXX==ERROR MESSAGE END==XXXXXXXXX"

  end

#2013jan17 : senthil : Checks in the entered keyword is an exact product_name, if yes, navigate to specific page
# SImple technique, if @specific_flag is not 1 and if it is 0,2,3,4,5,6.. then goto generic page otherwise specific page.
#================ Home Page => Specific Page checker ================

  def send_to_specific_if_exact_product_name(raw_key)

    @specific_flag = 0

    result_set = ProductsFilterCollections.plain_exact_search(raw_key).compact

    if !(result_set.blank?)

        @result_hash = Hash[result_set.map{|i| [i.filter_id,[i.sub_category_id,i.filter_key]]}]
        # example {mobiles_list_id => [sub_category_id,filter_key]}

        self.check_unique_product_name_in_part2(@result_hash)

    else

      @no_exact_results_flag = 1

    end

  end

  def check_unique_product_name_in_part2(result_hash)

    result = result_hash.values.uniq

      if result.size == 1

          set_sub_category_name(result[0][0])
          
          columns = RubyUtilities.m_columns(@sub_category_name)
                            
                            #model is a method defined in ruby_utilities 
          @specific_flag =  model.check_distinct_product_name_count(result_hash.keys)
          
          @product_name = s_to_url(result[0][1])
          
          @product_identifier = s_to_url(model.get_identifier_from_id(result_hash.keys[0]))


      else

          @specific_flag = 0

      end

  end


#===================================================
#2013jan17 : senthil : The main Crawlfish search form and the methods required
#================ Home Page => Specific Page checker ================


  def set_area_id_names_generic(id = "multiple_area_ids")
  
    a_ids = params[id.to_sym].to_s

    if !(a_ids.empty?)    

      areas = a_ids.split("-")

      if areas.size <= 1

        @areas = Branches.find_by_branch_id(areas).branch_name

      else

        @areas = areas.join("-")

      end

    else

      @areas = nil

    end

  end
  # UC
  def set_type
    
    p = params[:type]   

    if !p.nil?
      
      @type = p
    
    end
    
  end

 def set_city
 
   @cities = Cities.all.map{|i| i.city_name}
 
   p = params[:city]   

   if p.nil?

        if request.remote_ip == '127.0.0.1'
          # Hard coded remote address
          @client_ip = '114.143.198.25'
          #'122.164.56.246' => chennai
          #'94.200.22.213' => no result for city
          #'114.143.198.25' => mumbai
        else
          @client_ip = request.remote_ip
        end

        url_parsed = URI('http://freegeoip.net/csv/'+@client_ip)
        
        #out = Net::HTTP.get_response(url_parsed).body.gsub(/\"/,'').gsub(/\n/,'0').split(",")[5]
        out = "chennai"

        if !(out.blank?)
          @city = out.to_s
          c = Cities.where(:city_name => @city).first
          if c.nil?
              @city = "chennai"
              @current_city = Cities.where(:city_name => @city).first
          else
              @city = out.to_s
              @current_city = c
          end
        else
          @city = "0"
          @current_city = "0"
        end
    
    else
       @city = p.to_s
       @current_city = Cities.where(:city_name => p.to_s).first
    end

  end

  def set_shops_count

    if @current_city != "0"

      @shops_count =  @current_city.vendors.size

    end

  end

  def set_areas_count

    if @current_city != "0"

      @areas_count =  @current_city.areas.size

    end

  end

  # Not used in the current application, will be used in future for manipulating city names
  def replace_old_city_names(city)

    if ["madras","chennai"].include?(city.downcase)

      Cities.where(:city_name => "chennai").first

    else

      "0"

    end

  end

  def form_index_links

    set_sub_categories

    # called from ruby_utilities.rb module
    form_all_links
    
  end

  def set_areas

      @areas = Branches.where("branch_name like ?", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json { render :json => @areas.map{|i| {"id"=> i.branch_id,"branch_name" => i.branch_name} } }
      end

  end
  
  def update_areas
  
    @areas = Branches.nearby(params[:area_ids].gsub(/-/,","))
    
    render :partial => 'shared/areas'  
  
  end

  def update_numbers
    self.help_update_numbers
    render :partial => ('shared/numbers')
  end
  
  def help_update_numbers
  
    if !(params[:city].nil?)

      @current_city = Cities.where(:city_name => params[:city].to_s).first

    end

    if !(params[:area_ids].nil?)

      @area_ids = params[:area_ids]

      @areas_count = @area_ids.split("-").size

      @shops_count = Branches.find(@area_ids.split("-").collect{ |s| s.to_i }).map {|i| i.vendors.size}.sum

    else

      set_shops_count

      set_areas_count

    end
  
  end

# functions defined after this section are used by merchants
#================ MERCHANTS - START ================


  def merchants_home_preliminary_actions

    @merchants_list = MerchantsLists.new
    @merchant = Merchants.new
    @areas = []

  end

  def login_required
    if session[:merchant_id]
      return true
    end
    flash[:notice]='Please login to continue'
    #session[:return_to]=request.request_uri
    redirect_to :controller => "merchants", :action => "home"
    return false
  end

  def and_go_login_required
    if session[:and_go_id]
      return true
    end
     redirect_to :controller => "and_go", :action => "index"
    return false
  end


  def current_merchant(vendor_id = 0)

    if (vendor_id == 0)

        if !(session[:merchant_id].nil?)

           @current_merchant ||=  Merchants.find(session[:merchant_id])

        else

           @current_merchant = nil

        end

    else

        @current_merchant = Merchants.find_by_vendor_id(vendor_id)

    end

  end

  def set_logged_in_merchant

    @logged_in_merchant = Merchants.find(session[:merchant_id])

  end

  def set_branches(vendor_name)

      @branches =  Branches.get_vendor_id_branch_name(vendor_name)

  end

  def set_type_vendor_vendor_id(vendor_id = 0)

     if (vendor_id == 0)

       current_merchant

     else

       current_merchant(vendor_id)

     end

     @type = @current_merchant.business_type

     @vendor = VendorsList.where(:vendor_id => @current_merchant.vendor_id)

     @vendor_id = @current_merchant.vendor_id

  end

  def get_vendor_coupons_count(vendor_id,title)

    if(vendor_id !=0 )

        merchant_logs = TempMerchantLogs.where("vendor_id = ?",vendor_id).order("created_at DESC").select("log_date").first
    
        vendor_logs = "";
    
        if(merchant_logs.nil?)
        vendor_logs = VendorsList.where("vendor_id = ?",vendor_id).select("subscribed_date").first
        log_date = vendor_logs.subscribed_date
        else
        log_date = merchant_logs.log_date
        end

        @notifications_count = VendorCoupons.where("vendor_id =? AND DATE(created_at) =?",vendor_id,log_date)
        
        if(!@notifications_count.nil?)
             if(@notifications_count.count.to_i > 0)
                 @meta_merchant_login_title = '(' + @notifications_count.count.to_s + ') ' +title
                  else
                 @meta_merchant_login_title = title
                  end
              else
                 @meta_merchant_login_title = title
              end

    else
        @meta_merchant_login_title = title
    end

  end

  def set_cache_buster

    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"

  end

#================ MERCHANTS - END ================

# functions defined after this section are used generally
#================ GENERAL - START ================

   def redirect_to_specific_page(type,category_name,product_name,product_identifier,country,city = 0,area_names = 0)
     
     center = category_name+"/"+product_name+"/"+product_identifier+"/"+country.to_s

     if type == "online"

       redirect_to '/online-price-comparison/'+center

     elsif type == "local"

       redirect_to '/price-comparison/'+center+"/"+city.to_s+"/"+area_names.to_s

     end

   end


  def to_u(input)

    input.gsub!(/(.)([A-Z])/,'\1_\2').downcase!

  end

  def f_stripstring(input)

    input.downcase.squeeze(" ").gsub(/ /,"").gsub(/,.-/,"")

  end

  def set_product_id(name,identifier = "0")

       if !(name.nil?)
         
           #called from module ruby_utilities
           product_from_name_identifier(name,identifier)

       end

  end

  def set_product_identifier(product_id,category_name)
  
    set_sub_categories(category_name)
  
    columns = RubyUtilities.m_columns(@sub_category_name)
    
    model.get_identifier_from_id(product_id)

  end

  # Removed identifier since identifiers/variants are treated shop specific
  def set_product_name_identifier

    @product_name = params[:product_name]#1. set the prodcut_name variable

  end

  def set_country

    if !(params[:country].nil?)

        @country = params[:country].to_s

    end

  end

#================ GENERAL - END ================

# functions defined after this section are used in specific_search
#================ SPECIFIC SEARCH - START ================

  # 2012aug10:Senthil:  This will fetch the minimum and maximum for a group or individual products_list_id(s) and sub_category_id is passed.

  def get_price_range(product_ids_array,sub_category_id,type)

     #Senthil: removed exclude_availabilities_array since, availablility should be handled in specific page and
    #because of handling it here, some products shows up without price.

     #set_excludable_availability_ids(1)
                                       # altering this method to fetch only online price
     General.get_price_range(product_ids_array,sub_category_id,"online").sort_by{|i| i[1]}

  end

   def set_view_name

    if !(params[:view_name].nil?)

      @view_name = params[:view_name].to_s

    else

      @view_name = "generic" + request.session_options[:id]

      Rails.logger.debug "DEBUG-978666-params[:view_name] was nil" if Rails.logger.debug?

    end

  end

  def set_search_case# the purpose of this method is to set the search_type params to an instance variable in all the pages of crawlfish public users to determine which search box should be rendered.
  # there is a reason behind why it is search_case and not search_type. It is, in specific_page, during pagination of the grids, a url regexp match is done in jQuery to find the parameter "type". If you keep search_type, this interferes with it.

    if !(params[:search_case].nil?)

      @search_case = params[:search_case].to_s

    else

      error_log("params[:search_case] was nil")

    end

  end

  def set_excludable_availability_ids(include)

    if include == 1

        if @sub_category_name == "books_lists"

          @excludable_availability_ids = get_availability_ids(["out of stock","permanently discontinued"])

        else

          @excludable_availability_ids = get_availability_ids(["out of stock"])

        end

    elsif include == 0

        if @sub_category_name == "books_lists"

          @excludable_availability_ids = get_availability_ids(["permanently discontinued"])

        else

          @excludable_availability_ids = get_availability_ids

        end

    end

  end

  def set_sub_category_name(sub_category_id)

    @sub_categories.each do |i|

        if i.sub_category_id == sub_category_id

            @sub_category_name = i.sub_category_name

            @category_name = i.category_name

        end

     end

  end

  def set_sub_category_id_from_category_name(category_name)

    @sub_category_id = Subcategories.find_by_category_name(category_name).sub_category_id

  end

  def get_availability_ids(exclude_availabilities_array = ["default"])

      columns = RubyUtilities.m_columns(@sub_category_name)
      
      columns[5].camelize.constantize.get_availability_ids(exclude_availabilities_array)

  end

   def set_generic_meta_tags

    # This part is to add keywords dynamically to 'keyword meta tag' in html.erb    
    if !session[:query].nil?
        m_session_value = session[:query].gsub('\'','').gsub('\"','').gsub('\"','').gsub('&quot;','')
        @meta_generic_keywords=m_session_value
        @meta_generic_keywords += ",price of " + m_session_value + " in india"
        @meta_generic_keywords += ",price of " + m_session_value + " in chennai"
        @meta_generic_keywords += "," + m_session_value + " india"
        @meta_generic_keywords += "," + m_session_value + " chennai"
        @meta_generic_keywords += "," + m_session_value + " price"
        @meta_generic_keywords += "," + m_session_value + " buy online"
        @meta_generic_keywords += ",buy " + m_session_value + " online"
        @meta_generic_keywords += ",online price comparison"
        @meta_generic_keywords += "," + m_session_value + " deals"
        @meta_generic_keywords+=",crawlfish"
        @meta_generic_keywords+=",price comparison india"
        @meta_generic_keywords+=",books, mobile phones"
        @meta_generic_keywords+=",location based price search engine"

    else
        @meta_generic_keywords="buy online in india"
        @meta_generic_keywords+=",price comparison india"
        @meta_generic_keywords+=",books, mobile phones"
        @meta_generic_keywords += ",online price comparison"
        @meta_generic_keywords+=",location based price search engine"
        @meta_generic_keywords+=",crawlfish"
        @meta_generic_keywords+=",price of books in india"
        @meta_generic_keywords+=",price of mobile phones in india"
        @meta_generic_keywords+=",price of books in chennai"
        @meta_generic_keywords+=",price of mobile phones in chennai"
         end
      
    #This part is to add description dynamically to 'description meta tag' in html.erb
    if !session[:query].nil?
        @meta_generic_description=session[:query].gsub('\'','').gsub('\"','').gsub('&quot;','') + ": Find, Compare, Decide @ CrawlFish.in. Only place in india to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
    else
        @meta_generic_description="Find, Compare, Decide @ CrawlFish.in. Only place in india to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
    end
    
    #This part is to add title dynamically to 'title meta tag' in html.erb
    if !session[:query].nil?
        @meta_generic_title=session[:query].gsub('\'','').gsub('\"','').titlecase + ": Find, Compare, Decide @ CrawlFish.in"
    else
        @meta_generic_title="Find, Compare, Decide @ CrawlFish.in"
    end
    

  end

  def set_price_finder_meta_tags

    # This part is to add keywords dynamically to 'keyword meta tag' in html.erb    
    @meta_generic_keywords = "online price comparison"
    @meta_generic_keywords+=",crawlfish"
    @meta_generic_keywords+=",price comparison india"
    @meta_generic_keywords+=",books, mobile phones"
    @meta_generic_keywords+=",location based price search engine"
    @meta_generic_keywords="buy online in india"
    @meta_generic_keywords+=",price finder"
    @meta_generic_keywords+=",price of books in india"
    @meta_generic_keywords+=",price of mobile phones in india"
    @meta_generic_keywords+=",price of books in chennai"
    @meta_generic_keywords+=",price of mobile phones in chennai"
      
    #This part is to add description dynamically to 'description meta tag' in html.erb
    
    @meta_generic_description="Price Finder - Find, Compare, Decide @ CrawlFish.in. Only place in india to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
    
    
    #This part is to add title dynamically to 'title meta tag' in html.erb
    
    @meta_generic_title="Price Finder - Find, Compare, Decide @ CrawlFish.in"
    
  end

  
  def fetch_ad_list_details(ad_place,vendor_id)

    
  end

#================ SPECIFIC SEARCH - END ================



end

