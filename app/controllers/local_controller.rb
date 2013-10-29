class LocalController < ApplicationController
before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range,:pop_7,:except => [:generate_coupon_code]

  include RubyUtilities
  
  include FilterCategory

  require 'open-uri'

  include ActionView::Helpers::TextHelper

  include ActionView::Helpers::NumberHelper
  
  include LocalHelper

# functions defined after this section are direct
#================ Direct Functions - START ================
  def index

  end

  def show_local_shop 
      
      set_url_params# called from application controller set all the parameters from the URL to instance variables
      
      set_sub_categories# set @sub_categories which is just Subcategories.all
      
      set_sub_categories(@category_name)# set @sub_category_name, @sub_category_id

      set_product_id(@product_name)#2. set the product_id, product activerecord using only product_name
      
      set_vendor(@vendor_name,@area_names)#sets vendor active record, id , name and other things using the area_names passed in the url - Edited by senthil 2013may18

      self.set_unique_id

      self.set_local_grid

      self.set_areas
      
      set_current_branch
      
      @rate = set_ratings(@vendor_id)
      
      @click = set_clicks_no(@vendor_id)

      #self.set_local_meta_tags#added this on 2012jul12 to set meta tags for local shop page

      #fetch_ad_list_details("local",0)
      
      self.set_image_url
     
      @list = @list.nil? ? "details" : @list
      
      if @list == "map"
      
        self.set_map_params
      
      elsif @list == "reviews"
      
        vendor_rating
        
      elsif @list == "products"
      
        show_shop_page
        
      end
      
      save_clicks
  
      render ('local/local_shop')

  end  
  
  
  
  def set_map_params

    @markers = []

    show = @vendor_name.titleize[0..10] + ".."
        
    color = "C42525|FFFFFF"

      tail = '/price-comparison/'+ @category_name + "/" + @product_name + '/' + @country + '/' + @city + "/"+ @area_names + "/"+ @vendor_name

      @markers << {"picture"=>"https://chart.googleapis.com/chart?chst=d_bubble_icon_text_small&chld=shoppingcart|bb|#{show}|#{color}","width"=>250,"height"=>100,"lat"=> @vendor.latitude,"lng"=> @vendor.longitude,"link" => tail}

      @json = @markers.to_json
    
  end
  
  def set_image_url
  
    result = set_columns_category(@sub_category_id)
  
    category = result[1].chomp("s")
    
    @product_image_url = @product.send(category+"_image_url")
  
  end
  
  def show_gmap

      set_url_params("vendor_name,branch_name")

      @latitude_longitude = VendorsList.get_latitude_longitude(f_stripstring(@vendor_name),f_stripstring(@branch_name))

      render :partial => "local/gmap"

  end

  def change_vendor_details

    set_vendor_id

    set_vendor

    render :partial => "local/local_shop_details"

  end

  def generate_coupon_code

    set_url_params
    
    set_city
    
    @error = 0
    
    @vendor = VendorsList.where(:vendor_id => @vendor_id)
    
    if @unique_id.blank?
         obj = ProductsFilterCollections.where("replace(filter_key,'-',' ') = (?)",@product_name.gsub(/-/," ")).first
         @product_id = obj.filter_id
         @sub_category_id = obj.sub_category_id
         
         out = LinkProductsListsVendors.get_unique_id(@product_id,
                                                             @sub_category_id,
                                                             0,
                                                             @vendor_id)[0]
         @unique_id = out.blank? ? 0 : out
                                                             
    end
    
    if (@unique_id != 0)
    
        c_id = CustomerCareEntries.c_id(@cc_mobile_number)
        
            if c_id.empty?
            
              c = CustomerCareEntries.new
              
              c.customer_name = @customer_name
              c.customer_phone_no = @cc_mobile_number
              c.customer_city = @city
              c.customer_area = @branch_alias_name.blank? ? "na" : @branch_alias_name
              c.customer_email = "na"
              c.enquiry_type = "send_sms"
              c.category_enquired = @sub_category_id
              c.product_enquired = @product_id
              c.shops_referred = @vendor_id
              c.followup = "n"
              c.source = request.fullpath.split("/")[1]
              c.misc = "na"
            
              if c.save
              
                @c_id = c.id
                
              end
              
            else
            
              @c_id = (c_id.map &:id)[0]
              
            end 
        
        self.set_coupon_code
        
        if !@product_price.nil? 
            #send_coupon_code_mailer(@product_id,@sub_category_id,@vendor_id,@coupon_code,@product_price) 
        else
           # send_coupon_code_mailer(@product_id,@sub_category_id,@vendor_id,@coupon_code,0) 
        end
    else
     @error = 1
    end
    
    render :partial => "local/coupon_code"

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_coupon_code

    if(@coupon_code.nil?)
     @coupon_code,@existing_coupon_code_flag = VendorCoupons.generate_coupon_code(@vendor_id,@unique_id,@sub_category_id,@cc_mobile_number,@c_id)
    else
      @coupon_code = "nocode"
    end
    
  end


  def get_vendor_names(vendor_id)

     if(vendor_id!=0)
      @vendor =  VendorsList.where(:vendor_id => vendor_id)

      @vendor.flatten.each do |j|
            @vendor_alias_name = j.vendor_alias_name
            @branch_alias_name = j.branch_alias_name
      end
     end

  end

  def set_product_price(unique_id)

     if (unique_id!=0)

      local_grid = LocalGridDetails.where(:unique_id => unique_id).select("price").first
      @product_price = local_grid.price

     end

  end

  def get_coupon_code_id(coupon_code)

     coupon_details = VendorCoupons.select("coupon_id").where("coupon_code=?",coupon_code).first

     coupon_details.coupon_id
     
  end

  def set_unique_id
      @unique_id = LinkProductsListsVendors.get_unique_id(@product_id,@sub_category_id,0,@vendor_id)
  end

  def set_areas

      @areas =  Branches.get_vendor_id_branch_name(url_to_s(@vendor_name),@product_id,@sub_category_id)

  end  

  def set_local_grid

    if !(@unique_id.nil?)

      @local_grid = LocalGridDetails.where(:unique_id => @unique_id)

    end

  end


 #================ Auxillary Functions - END================

end

