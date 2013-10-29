class CategoryController < GenericPageController
before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range

# functions defined after this section are direct
#================ Direct Functions - START ================

  def switch

    set_type

    set_country

    set_city

    set_area_id_names_generic

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count

    self.create_instance_variables# create the instance variables that are totally necessary for the switching the category.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    puts "View #{@view_name} ALREADY EXIST..."

    set_master_hash_from_generic_view# The master_hash which was created in the create_instance_variables method will be set from the generic_view based on the data present in the view_name procured from the url parameter as params[:view_name]

    puts "this is master hash after setting from generic_view #{@master_hash}"

    loop_categories(@sub_category_flag)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count. Located in application_controller, FOR ONLY THE CURRENT Subcategory.

    # 2012sep27 : senthil :  commented this line out, the importance of this line below is, if its present all the categories will persist even if they are selected, if its removed the selected/clicked category will persist and the other categories will vanish.
    #self.set_products_count_of_other_categories(@master_hash.keys - [@sub_category_flag])

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    fetch_ad_list_details("generic",0)

    render ('search/generic')

  end

#================ Direct Functions - END ================

  # functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def create_instance_variables

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}# this is declared without being used anywhere because in the view _filters_results.html.erb, .empty? is used to check which needs this variable to be declared. Bad one.

    @sub_category_flag = params[:sub_category_id].to_i# Setting the @sub_category_flag which really important and this keeps the whole filtering process informed about the current sub_category_id.

    @view_name = params[:view_name]# @view_name is set.

    @price_range_final = Hash.new

  end

  def set_products_count_of_other_categories(sub_category_ids_array)

    sub_category_ids_array.each do |i|

      set_products_count(i)

    end

  end

#================ Auxillary Functions - END ================


end

