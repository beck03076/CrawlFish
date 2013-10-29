class MainController < ApplicationController

  include RubyUtilities
  # This line is to include the modules that give access to this class to the net methods to get the IP address
  require 'net/http'

  def index

     timestamp = Time.now
     hour = timestamp.strftime("%H")
    if  hour >= "0" && hour <= "12"
      flash[:notice] = "Good Morning, Enter a product name to compare price"
    elsif hour > "12" && hour <= "16"
      flash[:notice] = "Good Afternoon, Enter a product name to compare price"
    elsif hour > "16" && hour < "24"
      flash[:notice] = "Good Evening, Enter a product name to compare price"
    end

   # The following line is to know whether or not the gift section once recommended by senthil is active
   # @gifts_active_flag = FeaturesMasterValues.where("feature_name = ?",'gifts').select("active_flag").first

    @country = "india"

    # This wil find the cuurent city based on the IP address taken from the clients machine w/o the client permission
    set_city
    
    # Sets the variable @sub_categories with all records in sub_categories
    set_sub_categories

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count
    
    @areas =  []
    
    form_index_links
    # setting the generic hub areas in the home page
    g_hub
    # setting the vendor top in the home page
    v_top
    # setting all areas top 70 featured at crawlfish
    a_areas
    # setting all online shops list to a variable
    o_shops
    #setting @pop with popular mobiles
    pop
    #setting @p_p_range with random highest price ranges, like mobiles below 50,000
    p_p_range
    #setting @pop_7 with random 7 popular products from random categories
    pop_7
    #setting @shops_8 with random 8 top vendors
    shops_12
    # setting prod_count to display in the left menu of popular products
    set_prod_count
    
    render ('shared/index')
  end
  # setting the no of products sold for each category to display in home page.
  def set_prod_count
  
    p = LinkProductsListsVendors.select("sub_category_id as cat,
                                                   COUNT(DISTINCT(products_list_id)) as c").group("sub_category_id")
    @prod_count = Hash[ p.map{ |c| [c.cat,c.c] } ]
  
  end
  
  def open_add_shop
  
   render "shared/add_your_shop"
  
  end
  
  def add_shop
  
    set_url_params
    
    TestMailer.add_your_shop(@type,@shop_name,@name,@ph).deliver
    
    render :text => "You will receive a phone call within 2 days!"
  
  end
  
  def complain
  
    set_url_params
    
    TestMailer.complain(@type,@customer_name,@customer_email,@complain).deliver
    
    render :text => "You will be acknowledged within 2 days!"
  
  end

  def show_gifts

    @gifts = Gifts.all

    render ('shared/show_gifts')

  end
  
  def not_ready

   @msg1 = "Noooooooooooooooo!!!!!! <br/>
           We are not ready yet!<br/>"
   
   @msg2 = "Come back after sometime!"
           
   render :layout => false
   
  end
  
end

