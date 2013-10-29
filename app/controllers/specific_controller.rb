class SpecificController < ApplicationController
before_filter :form_index_links,:g_hub,
              :v_top,:o_shops,:p_p_range,:a_areas,:pop_7,
              :except =>[:grab_price,
                        :update_online_price,
                        :latest_price_send,
                        :get_pattern,
                        :vendor_rating,
                        :vendor_rating_save,
                        :sms,
                        :update_online_grid,
                        :update_local_grid]


   #The back browser button will be busted with a method for search_controller and price_search_controller by calling a before_filter :set_cache_buster. The cached pages wont be used for search_controller, every time it will render new pages.
   #commented this below line as it was causing issue related to form resubmission in IE and Google Chrome.
  #before_filter :set_cache_buster

  include SpecificHelper

  include SearchHelper
  
  include RubyUtilities
  
  include FilterCategory

# functions defined after this section are direct
#================ Direct Functions - START ================  

  def redirect
  
    set_url_params
    save_clicks
    l = LinkProductsListsVendors.where(:products_list_id => @product_id,
                                       :sub_category_id => @sub_category_id,
                                       :vendor_id => @vendor_id)
                                       
    u_id = l.map{|i| i.unique_id }
    if l.size == 1
      redirect_to OnlineGridDetails.find(u_id[0]).redirect_url
    elsif l.size > 1
      @re = OnlineGridDetails.where(:unique_id => u_id) 
      render ("specific/redirect")
    end
    
  end

  def sms
   
    set_url_params  
  
  end
  
  def latest_price_send
   
    set_url_params  
    
    #send the sms here. You have @vendor_id,@product_id,@sub_category_id,@smsx
    
    render :text => "Sent!"
  
  end
  
  def buy_send
   
    set_url_params  
    
    #send the sms here. You have @vendor_id,@product_id,@sub_category_id,@smsx
    
    render :text => "Sent!"
  
  end

  def update_online_price
  
   set_url_params("data")
   
   if !(@data.nil?)
  
       @data.each do |a|
       
         i = a.split("|")
        
         OnlineGridDetails.find(i[0]).update_attributes(:price => i[1].scan(/\d/).join.to_i, :updated_at => Time.now)
        
       end
       
       render :text => "ok"
   
   else
   
       render :text => "no"
   
   end
         
  end
  
  def grab_price

    [:controller,:action].each {|i| params.delete(i)}
    
    agent = Mechanize.new { |agent|
                              agent.open_timeout   = 5
                              agent.read_timeout   = 5
                            }
    
    i =  params[:data].split("|")
    
    v_id = i[1].to_i
              
    u_id = i[0]
              
    pattern = self.get_pattern(v_id)
            
    page = agent.get(i[2])
              
    result =  page.parser.xpath(pattern)
              
      if !(result[0].nil?)
            
        price = "Rs." +  result[0].to_html.gsub(/,/,"").scan(/\d+/)[0]
        
      else
      
        price = "N.A"  
              
      end
        
    render :text => u_id + "|" + price   
 
  end
  
  def get_pattern(v_id)
  
    if v_id == 3
    
      "//div[@class='price']//span[@id='sp']/text()"
    
    elsif v_id == 4 
    
      "//div[@class='offinfo']//span[@class='offsp']/text()"
      
    elsif v_id == 67
    
      "//div[@class='pricebox clearfix']//span[@class='price-current']/text()"
      
    elsif v_id == 68
    
      "//div[@id='pricediv']//span[@class='red16']/text()" 
      
    elsif v_id == 2
    
      "//input[@id='hdnOurPrice']/@value"   
      
      
    elsif v_id == 1
    
      "//div[@class='price-table']//span[@class='fk-font-finalprice fk-font-big fk-bold final-price']/text()"
      
      
     elsif v_id == 122
    
      "//div[@id='price-and-save-details']//span[@id='whole-sale-price']//span[@itemprop='highPrice']/text()"
      
      elsif v_id == 123
    
      "//div[@class='priceshipinfo']//span[@itemprop='price']/text()"
      
      elsif v_id == 68
    
      "//div[@id='pricediv']//span[@class='red16']/text()"
    
      end
  
  end
  
  def vendor_rating_save

    set_url_params("shops_referred,review,rating,customer_name,customer_email,customer_phone_no,vendor_id")
    
    @shop = VendorsList.find(@vendor_id).vendor_name
    
        c_id = CustomerCareEntries.c_id(@customer_phone_no,
                                        @customer_email)    
        if c_id.empty?
        
          c = params
        
          [:utf8,
             :authenticity_token,
             :rating,
             :vendor_id,
             :review,
             :commit,
             :controller,
             :action].each {|i| c.delete(i)}
        
          if  c = CustomerCareEntries.create(c)
          
            c_id = c.id
            
          end
          
        else
        
          c_id = (c_id.map &:id)[0]
          
        end 
        
        if @review.blank?
          @msg = "Review not posted, please write something like excellent or worthless or even a story!"
        elsif @rating.blank?
          @msg = "Please click on a star and post your review!"
        else

            rate = {:vendor_id => @vendor_id,
                    :ratings => @rating,
                    :reviews => @review,
                    :customer_id => c_id,
                    :created_at => Time.now}
                    
            VendorsRatings.create(rate)
            @msg = "<span class='g-text'>Thanks! Ratings saved successfully.</span>" 
        end
    
    @reviews = VendorsRatings.reviews(@vendor_id)
        
    render :partial => "show_reviews"

  end
  # SEO temp work around method the displays small, unique and valuable URL
  def online
    set_url_params
    
    @type = "online"
    @country = "india"
    @price_range_final = Hash.new
    
    set_sub_categories(@category_name,0,0)
    
    c = RubyUtilities.m_columns(@sub_category_name)
    @product = model.where(:name_slug => @product_name).first    
    @product_id = @product.send(c[0])
    @product_identifier = @product.send(c[3])
    
    self.set_grid_and_count(@type)
    self.set_price_range
    self.set_product_details
    self.set_a_avl
    
    vendor_ids = @online_grids.map {|i| i.vendor_id }
    @click = set_clicks_no(vendor_ids)
    @rate = set_ratings(vendor_ids)
    
    render ('specific')
  end

  def online_specific_search #This function is called when a request from generic page arrives.

    help_specific_search_head("online")

    help_specific_search_tail("online")
    
    vendor_ids = @online_grids.map {|i| i.vendor_id }
    
    @click = set_clicks_no(vendor_ids)
    
    @rate = set_ratings(vendor_ids)
    
    render ('specific')

  end

  def local_specific_search #This function is called when a request from generic page arrives.

    help_specific_search_head("local")

    set_city

    self.set_area_id_names_specific

    help_specific_search_tail("local")
    
    self.set_grid_var(@local_grids) # This method sets the vales of @branches_no( Number of branches for each vendor_name), @clicks_no (vendor clicks count), @admin (vendor_admin_branch) All the above mentioned variables are Hashes with vendor_ids as keys
    
      if @area_ids == 0 
    
        self.set_hub
        
      else  
    
        self.set_nearby([2,4,6])# should a array be passed    
                
      end
      
    @area_ids_now = @area_ids    
   
    render ('specific')

  end

  def help_specific_search_head(type)
  
    set_sub_categories

    @type = type

    self.set_instance_variables

    set_sub_categories(params[:category_name],0,0)# called from application controller because the same method is also called in many other places, its a good method that sets 3 variables given any one of the following variables in the right order.
    #1.category_name
    #2.sub_category_name
    #3.sub_category_id
    #It sets the other 2 variables.
    
    # remvoed product_identifier
    set_product_name_identifier# set the name and identifier from the URL.

    set_product_id(@product_name)#2. set the product_id, product activerecord using the product_identifier and product_name   

    set_country

  end

  def help_specific_search_tail(type)

    set_excludable_availability_ids(0) # called from application controller because the same method is also called in bnm_controller

    self.set_grid_and_count(type)

    self.set_price_range

    self.get_deals

    #self.set_specific_meta_tags# self function to set meta tags dynamically

    self.set_mrp #A new method added to set the values of mrp to be displayed in the specific page.
    
    self.set_product_details
    
    self.set_a_avl

  end
  
  
  def change_product_identifier
  
    set_url_params     
   
    @product_identifier = set_product_identifier(@product_id,@category_name)
    
    @type = (@type == "1") ? "local" : "online"
    
    redirect_to_specific_page(@type,@category_name,@product_name,s_to_url(@product_identifier),@country,@city,@area_names)

  end
  
  def maps
  
    help_specific_search_head("local")

    set_city

    self.set_area_id_names_specific

    set_excludable_availability_ids(0) # called from application controller because the same method is also called in bnm_controller
    
    if @area_ids == 0 
    
        self.set_hub
        
      else  
    
        self.set_nearby([2,4,6])# should a array be passed
        
      end

    self.set_grid_and_count("local")
    
    self.set_map_params
  
  end
  
  def update_online_grid
  
    set_url_params("val,product_id,sub_category_id,excludable_availability_ids,product_name,category_name,country,kind")
    
    opt = self.sort_opt(@val)
    
    @excludable_availability_ids = @excludable_availability_ids.split
    
    self.set_grid_and_count("online",opt)
    
    vendor_ids = @online_grids.map {|i| i.vendor_id }
                  
    @click = set_clicks_no(vendor_ids)
    
    @rate = set_ratings(vendor_ids)
    
    prep_rate_click("online",@val)
    
    # This is good to know the request is for online shops
    @type = "online"
    
    render :partial => 'actual_online_grid'
  
  end
  
  def update_local_grid
  
    set_url_params("val,product_id,sub_category_id,excludable_availability_ids,area_ids,product_name,product_identifier,category_name,city,country,kind")
    
    @excludable_availability_ids = @excludable_availability_ids.split
    
    @area_ids = @area_ids.gsub(/-/,",")
      
     if @kind == "slide"       
    
        temp = Branches.nearby(@area_ids,@val)
    
        @area_ids = temp == 0 ? 0 : temp.map{|i| i.branch_id }.uniq.join(",")
        
        if temp == []
    
          @local_grids = []
       
          @local_grids_count = 0
          
        else  
        
          self.grid(@product_id,
                    @sub_category_id,
                    @excludable_availability_ids,
                    @area_ids)
                    
        end
                  
     elsif @kind == "sort"
     
       opt = self.sort_opt(@val)
            
       @area_ids = @area_ids == "0" ? 0 : @area_ids

       self.grid(@product_id,
                  @sub_category_id,
                  @excludable_availability_ids,
                  @area_ids,
                  opt)
 
      end
      
     self.set_grid_var(@local_grids)
     
     prep_rate_click("local",@val)
     
     # This is good to know the request is for local shops
     @type = "local"
    
     render :partial => 'actual_local_grid'

  end
  
  def prep_rate_click(type,val)
  
    if ["rate","click"].include?(val) 
    
       instance_variable_set("@"+type+"_grids",self.sort_grid(val,type))
   
    end
     
  end
  
  def sort_opt(val)    
    if ["rate","click"].include?(val)
      "AFFILIATE DESC"
    elsif val == "price_asc"
      "if(PRICE=0,1,0),PRICE ASC"
    elsif val == "price_desc"
      "if(PRICE=0,1,0),PRICE DESC"
    else
      val + " DESC"
    end
  end
  
  def sort_grid(by,type)
  
    grid = eval("@"+type+"_grids")
    
    h_grid = grid.index_by &:vendor_id
    
    by = eval("@"+by)
    
    arr_by = by.sort_by{|k,v| v}.reverse.map{|i| i[0]}
    
    arr_by.map{|i| h_grid[i] }
    
  end

  
#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_a_avl# sets the variable @a_avl (stands for also available) populates the variable with top 3 opposite shops details  
      if @type == "local"        
          @a_avl = OnlineGridDetails.get_grid(@product_id,
                                              @sub_category_id,
                                              0).limit(3)
      elsif @type == "online"        
          @a_avl = LocalGridDetails.get_grid(@product_id,
                                              @sub_category_id,
                                              0,
                                              0).limit(7)
          if @online_grids_count < 5
            self.set_grid_var(@a_avl)
          end
                                              
          
      end
  end

  def set_hub# sets the variable @hub with the important areas in chennai
  
    @hub = Branches.areas_no(@product_id,@sub_category_id,0,1).map{|i| [i.b_name, i.nos]}
      
  end

  def set_nearby(arr)# sets the variable @2km,@4km, @6km if arr = [2,4,6], # should a array be passed
  
    @kms = Hash.new{|hash, key| hash[key] = Hash.new}
  
    arr.each do |i|
      
      a_ids = Branches.nearby(@area_ids,i).map{|i| i.branch_id }.uniq
      
      if !(a_ids.empty?)
      
        @kms[i] =  Branches.areas_no(@product_id,@sub_category_id,a_ids.join(",")).map{|i| [i.b_name, i.nos]}
      
      end
    
    end

  end

  def set_grid_var(grid)
  
    vendor_names = grid.map {|i| i.vendor_name }
    
    vendor_ids = grid.map {|i| i.vendor_id }
    
    @branches_no = self.set_branches_no(vendor_names)
    
    @click = set_clicks_no(vendor_ids)

    @admin = set_admin(vendor_ids)
    
    @f_flag = self.set_freeze(vendor_ids)
    
    @rate = set_ratings(vendor_ids)
 
  end
  
  def set_freeze(v_id)
  
    hash = {}
  
    VendorsList.select("vendor_id,freeze_flag").where("vendor_id IN (?)",v_id).each {|i| hash[i.vendor_id] = i.freeze_flag }
    
    hash
  
  end

  def set_branches_no(a)
  
    VendorsList.where("vendor_name IN (?)",a).group("vendor_name").size
  
  end

  def set_product_details
  
    result = set_columns_category(@sub_category_id)
    
    columns = result[0]
  
    category = result[1].chomp("s")
    
    @identifier_type = columns[3]
  
    @product_image_url = @product.send(category+"_image_url")
    
    #called from ruby_utilities
    @options = model.use_identifier(columns[2],
                                     @product_name,
                                     columns[0],
                                     @product_id,
                                     @identifier_type,
                                     @sub_category_id)

  
  end
  
  def set_map_params

    @markers = []
    
    grid = @local_grids

    vendors = grid.map{|i| i.vendors }

    grid.each_with_index do |i,index|
    
      color = "C42525|FFFFFF"
      
      i.vendors.map { |i|
        @v_city = s_to_url(i.city_name)
        @v_area = s_to_url(i.branch_name)
        @v_vendor = s_to_url(i.vendor_alias_name)
      }
      
      show = @v_vendor.titleize[0..10] + ".."

      tail = '/price-comparison/'+ @category_name + "/" + @product_name + '/' + @country + '/' + @v_city + "/"+ @v_area + "/"+ @v_vendor

      @markers << {"picture"=>"https://chart.googleapis.com/chart?chst=d_bubble_icon_text_small&chld=shoppingcart|bb|#{show}|#{color}","width"=>250,"height"=>100,"lat"=> i.vendors.map{|i| i.latitude}[0],"lng"=> i.vendors.map{|i| i.longitude}[0],"link" => tail}

    end

    @json = @markers.to_json
    
  end

  def set_area_id_names_specific
  
    @areas_now = []
    
    if !params[:area_names].nil?

      @area_names = params[:area_names].to_s

      if (/^[\d-]*\d[\d-]*$/.match(@area_names).nil?)
      
        name = @area_names.titleize.gsub(/ /,"")

        temp = Branches.find_by_branch_name(name)
        
        @areas = Branches.where(:branch_name => name)
        
        if (temp.nil?)
        
          @area_ids = 0
          
          @no_area_results = 1
        
        else
         
          @area_ids = temp.id
          
          @areas_now << @area_names
          
        end

      else

        @area_ids = @area_names.gsub(/-/,",")
        
        @areas = Branches.where(:branch_id => @area_ids.split(","))
        
        @areas_now = @areas.map{|i| i.branch_name}

      end

    else

        @area_ids = 0
    
    end

  end

  def set_mrp

    if (!@product_id.nil?)

      @mrp = MobilesRates.get_mrp(@product_id)

    else

      @mrp = 0

    end

  end
  
  def set_price_range

     @price_range_final[@sub_category_id] = get_price_range([@product_id],@sub_category_id,@type)   

  end   

  def set_type

    if !params[:type].nil?

      @type = params[:type].to_s

    end

  end

  def set_grid_and_count(grid_type,sort = "AFFILIATE DESC")

    if (@excludable_availability_ids == 0 || @excludable_availability_ids.nil? || @excludable_availability_ids.empty?)

        @excludable_availability_ids = 0

    end

    if grid_type == "online"

       @online_grids = OnlineGridDetails.get_grid(@product_id,
                                                  @sub_category_id,
                                                  @excludable_availability_ids,
                                                  sort)

       @online_grids_count = @online_grids.length

    elsif grid_type == "local"
    
      self.grid(@product_id,
                @sub_category_id,
                @excludable_availability_ids,
                @area_ids)
       
       if @local_grids_count == 0
       
         # This is done when there are no results for areawise, render citywise
          self.grid(@product_id,
                @sub_category_id,
                @excludable_availability_ids)
         
         @area_ids = 0
         
         @no_area_results = 1
                  
       end

    end

  end
  
  def grid(p_id,s_c_id,e_id = 0,a_id = 0,s_id = "AFFILIATE DESC")
   
    @local_grids = LocalGridDetails.get_grid(p_id,
                                  s_c_id,
                                  e_id,
                                  a_id,
                                  s_id)
       
    @local_grids_count = @local_grids.length
  
  end

  def set_feature_name_image

    if @sub_category_name == "books_lists"

              @product.each do |book|

                  @feature_array = book.book_features.split("#")
                  @product_name = book.book_name
                  @product_image_url = book.book_image_url
          @desc_rating_widget=BooksReviews.where(:isbn13 => book.isbn13).map {|i| [i.description,i.average_rating,i.script]}.flatten

              end

    elsif @sub_category_name == "mobiles_lists"

              @product.each do |mobile|

                  @feature_array = mobile.mobile_features.split("#")
                  @product_name = mobile.mobile_name
                  @product_brand = mobile.mobile_brand
                  @product_image_url = mobile.mobile_image_url

              #2012aug01: Senthil: Setting the value of mobile color in an instance variable in order to display it in the mobile details of the specific page.
                  @mobile_color = mobile.mobile_color

              end

    end

  end
  
  def set_instance_variables

     @cities = Cities.find(:all)
     @areas = []
     @feature_array = Array.new
     @online_grids = Array.new
     @local_grids = Array.new
     @desc_rating_widget=Array.new
     @more = Hash.new{|hash, key| hash[key] = Array.new}

     @online_deal=Array.new
     @local_deal=Array.new
     @online_deal_product_details=Array.new
     @local_deal_product_details=Array.new

     @price_range_final = Hash.new

  end
  
  def get_deals

    @online_deal =     ProductDeals.get_online_deal
    @local_deal =     ProductDeals.get_local_deal

        @online_deal.each do |i|

    if i.sub_category_id == 1

      @online_deal_product_details = BooksList.fetch_exact_match(i.product_id)

      i.redirect_url = get_valid_url(i.redirect_url)

    elsif i.sub_category_id == 2

      @online_deal_product_details = MobilesLists.fetch_exact_match(i.product_id)

      i.redirect_url = get_valid_url(i.redirect_url)

    end
   end

  @local_deal.each do |i|

    if i.sub_category_id == 1

      @local_deal_product_details = BooksList.fetch_exact_match(i.product_id)

    elsif i.sub_category_id == 2

      @local_deal_product_details = MobilesLists.fetch_exact_match(i.product_id)

    end
   end


  end

  def get_valid_url(url)

    /^http/.match(url) ? url : "http://#{url}"

  end

  def set_specific_meta_tags

  # This part is to add keywords dynamically to 'keyword meta tag','description meta tag','title meta tag' in html.erb
  if @sub_category_name == "books_lists"

              @product.each do |book|

                  m_bookname = book.book_name.gsub('\'','').gsub('&quot;','').gsub('\"','')
                  m_isbn = book.isbn
      m_isbn13 = book.isbn13

      if (!m_bookname.empty?)

      @meta_specific_keywords = m_bookname
      @meta_specific_keywords += "," + m_bookname + " price in india"
      @meta_specific_keywords += "," + m_bookname + " price in chennai"
      @meta_specific_keywords += "," + m_bookname + " price compare india"
      @meta_specific_keywords += "," + m_bookname + " price compare chennai"
      @meta_specific_keywords += ",buy " + m_bookname + " online"

      end

      if (!@feature_array.nil?) && (!m_bookname.empty?)

        m_author = @feature_array[0].gsub('\'','').gsub('\"','').gsub('&quot;','').titlecase
      @meta_specific_keywords += "," + m_bookname + " by " + m_author
      @meta_specific_keywords += ",buy book " + m_bookname + " by " + m_author
      @meta_specific_keywords += "," + m_author

         end

      if (m_isbn.chomp.downcase.gsub(".","")!= "na")
        @meta_specific_keywords += "," + m_isbn
      end

      if (m_isbn13.chomp.downcase.gsub(".","")!= "na")
        @meta_specific_keywords += "," + m_isbn13
      end

       if !(m_bookname.empty?)
      @meta_specific_description=m_bookname + " : Find, Compare, Decide @ CrawlFish.in. Only place to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
      @meta_specific_title=m_bookname.titlecase + " : Find, Compare, Decide @ CrawlFish.in"
      else
      @meta_specific_description="Find, Compare, Decide @ CrawlFish.in. Only place to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
      @meta_specific_title="Find, Compare, Decide @ CrawlFish.in"
      end

              end

     elsif @sub_category_name == "mobiles_lists"

    if !@product.nil?

    @product.each do |mobile|

      if !(mobile.mobile_name.empty?)
        m_mobile_name=mobile.mobile_name.gsub('\'','').gsub('\"','').gsub('&quot;','')
        @meta_specific_keywords = m_mobile_name
        @meta_specific_keywords += "," + m_mobile_name + " price in india"
        @meta_specific_keywords += "," + m_mobile_name + " price in chennai"
        @meta_specific_keywords += "," + m_mobile_name + " price compare india"
        @meta_specific_keywords += "," + m_mobile_name + " price compare chennai"
        @meta_specific_keywords += ",buy " + m_mobile_name
        @meta_specific_keywords += ",buy " + m_mobile_name + " online"
        @meta_specific_keywords += ",buy " + m_mobile_name + " in chennai"
        @meta_specific_description=m_mobile_name + " : Find, Compare, Decide @ CrawlFish.in. Only place in india to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
        @meta_specific_title=m_mobile_name.titlecase + " : Find, Compare, Decide @ CrawlFish.in"
      else
        @meta_specific_description="Find, Compare, Decide @ CrawlFish.in. Only place in india to find price of books and mobile phones from online shopping portals in india and all retail shops in chennai"
        @meta_specific_title="Find, Compare, Decide @ CrawlFish.in"
      end
    end
    
    end
      end

  end


#================ Auxillary Functions - END================

end

