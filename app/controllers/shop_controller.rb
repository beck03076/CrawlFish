class ShopController < ApplicationController
before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range

  include RubyUtilities
  
  include FilterCategory

  require 'open-uri'

  def show
  
    set_sub_categories# set @sub_categories which is just Subcategories.all
  
    set_url_params# called from application controller set all the parameters from the URL to instance variables
    
    set_vendor(@vendor_name,@area)#sets vendor active record, id , name and other things using the area_names passed in the url - Edited by senthil 2013may18
    
    set_current_branch
    
    @rate = set_ratings(@vendor_id)
      
    @click = set_clicks_no(@vendor_id)
    
    @areas =  Branches.get_vendor_id_branch_name(@vendor.vendor_name)
    
    @list = @list.nil? ? "details" : @list
      
      if @list == "map"
      
        self.set_map_params
      
      elsif @list == "reviews"
      
        vendor_rating
        
      elsif @list == "products"
      
        show_shop_page
        
      end
  
  end
  
  def set_map_params

        @markers = []

        show = @vendor_name.titleize[0..10] + ".."
            
        color = "C42525|FFFFFF"

      @markers << {"picture"=>"https://chart.googleapis.com/chart?chst=d_bubble_icon_text_small&chld=shoppingcart|bb|#{show}|#{color}","width"=>250,"height"=>100,"lat"=> @vendor.latitude,"lng"=> @vendor.longitude}

      @json = @markers.to_json
    
  end
  
end
