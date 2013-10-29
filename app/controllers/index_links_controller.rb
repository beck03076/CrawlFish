class IndexLinksController < ApplicationController
  before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range

  include RubyUtilities
  
  def show_shops_list

     set_url_params
    
     @shops = Branches.find_by_branch_name(@area).vendors.where("admin != 0")
     
     @admin = set_admin(@shops.map{|i| i.vendor_id})
     
     render "show_shops"

  end

  def show_areas

    set_url_params

    set_sub_categories(@category_name)

    @index_areas = LinkProductsListsVendors.get_part1_present_items(@sub_category_id,@sub_category_name,"vendors_lists.branch_name as area","vendors_lists.branch_name",0,0,"local").map{|i| i.area}
    
  end

  def show_shops

     set_url_params
    
     set_sub_categories(@category_name)
     
     condition = 'find_in_set("'+@sub_category_name.to_s+'",vendor_sub_categories) <> 0'

     @shops = Branches.find_by_branch_name(@area).vendors.where(condition)      
     
     @admin = set_admin(@shops.map{|i| i.vendor_id})   
     
  end
  
  def show_products
  
    set_url_params
    @range = 0
    route = request.fullpath.split("/")[1]
    #out = route_full.split("-")
    #route = out[-2]
    @type = "online" 
    # 2013jun01 :Senthil : Temp fix by adding "price" and "online words in the or condition
    if route == "price-range" 
      @range = 1
    elsif route == "price-list" 
      @range = 0
    end
    self.help_show_products
  end

  def help_show_products

    set_sub_categories(@category_name)  
    #Area is set to 0 because in Mysql, it will search for branch_name IN (0), which wont have any effect when compared to branch_name IN (NULL)
    @area = 0
    @brand_name = url_to_s(params[:brand_name])
    
    v_columns = RubyUtilities.m_columns(@sub_category_name)
    
    brand = @sub_category_name + "." + v_columns[1]
    
    name = @sub_category_name + "." + "name_slug"
    
    identifier = @sub_category_name + "." + "identifier_slug"
    
    url = @sub_category_name + "." + v_columns[4]
    
    select_coulmns = name +' as name'+ ","+ url + ' as url'+','+ identifier + ' as identifier'+","+brand +' as brand'   
    
    if @range == 1
    
     id = @sub_category_name + "." + v_columns[0]
     
     out = LinkProductsListsVendors.price_step(@sub_category_id,
                                               @sub_category_name,
                                               @type,
                                               @position,
                                               @price,
                                               id,
                                               select_coulmns)
     out = out.map {|i| 
                    [i.name,i.url,i.identifier, i.brand]
                   }
     @products = out.group_by{|i| i[3]}
    
    elsif @range == 0

     @products = LinkProductsListsVendors.get_part1_present_items(@sub_category_id,
                                                                @sub_category_name,
                                                                    select_coulmns,
                                                                              name,
                                                                             @area,
                                                                    @brand_name,
                                                                    @type).map {|i| [i.name,i.url,i.identifier, i.brand.downcase]}.group_by{|i| i[3]}

    end
    
  end
  
  def show_shops_city_area

   set_url_params

    if @area.nil?

      @vendors = Cities.find_by_city_name(@city).vendors

    else

      @vendors = Branches.find_by_branch_name(@area).vendors

    end

    render ("index_links/local_shops")

  end


end

