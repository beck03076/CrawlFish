class FilterController < GenericPageController
before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range

  include FilterHelper
  
  include FilterCategory

  # functions defined after this section are direct
#================ Direct Functions - START ================

  def filters

    #preliminary_actions

    set_type

    set_country

    set_city

    set_area_id_names_generic

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count

    self.create_instance_variables_for_filters# create the instance variables that are totally necessary for the filtering the search results.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.
    
    set_sub_categories(0,0,@sub_category_flag)

    set_master_hash_from_generic_view# The master_hash which was created in the create_instance_variables method will be set from the generic_view based on the data present in the view_name procured from the url parameter as params[:view_name]

    @filter_extended_params = parse_params(params)#The url parameters will be parsed by this method and it will return an extended_params which will be used in the next step for proceeding with the filtering process. This is done because the url parameters are not so clean and it is prone to have duplicates.

    set_sub_categories(0,0,@sub_category_flag)
    
    temp = set_columns_category(@sub_category_id)
             
    products = eval("@"+temp[1])
             
    columns = temp[0]
             
    category = temp[1] 
    
    @master_hash[@sub_category_flag][:final] = Search.fetch_products_list_id(@filter_extended_params,@master_hash[@sub_category_flag][:final].flatten.map {|x| x},columns[0],@sub_category_name)

    loop_categories(@sub_category_flag)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count. Located in application_controller, FOR ONLY THE CURRENT Subcategory.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    fetch_ad_list_details("generic",0)

    render ('search/generic')

  end

  def suggestions

    set_type

    set_country

    set_city

    set_area_id_names_generic

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count

    #2012aug08 : Senthil :  commenting the method below, since it sets the params[:query]/@query variable to nil and currently the @query i.e. anything that is entered in the CF search box is very important because in the absence of the view, to recreate the view, the query is used to create the view.

    #set_query_as_nil# This will set the params[:query] as nil, since the user has clicked the suggestions links, it no more sensible to display the searched keyword in the search box

    self.create_instance_variables_for_suggestions_recommendations# create the instance variables that are totally necessary for rendering the result of a click on any suggestions links.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

    self.strip_filter_key# this method will remove all the special characters from @filter_key except the ones mentioned here =>

    @master_hash = FiltersCollections.filter_search(@master_hash,@filter_key,@sub_category_flag,@products_list_id_hash)# filter_search method is called from the FiltersCollections model, which is take sub_category_id and one filter_key and a products_list_id_hash which has the products_list_ids in part-1 as input and do a search on FiltersCollections table and return a master_hash

    form_master_hash_final# After populating :filter place of the master_hash the :final place has to be populated and this method does that. Located in application_controller.

    @matched_filter_keys = FiltersCollections.get_matched_filter_keys# this is a method in the model FiltersCollections to retrieve the words in the query which matched as a filter during FiltersCollections search.

    render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts, FOR ALL THE Subcategories.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

    render ('search/generic')

  end

  def cross_filters    

    @view_name = params[:view_name]

    @page = set_page(params[:from_pagination].to_i,params[:page].to_i)

    if !(params[:filter_type].empty?)

      params_filter_type = params[:filter_type]

        if !(remove_tree_filter_id_from_params(params[params_filter_type.to_sym],params[:tree_filter_id]).empty?)

          params[params_filter_type.to_sym] = remove_tree_filter_id_from_params(params[params_filter_type.to_sym],params[:tree_filter_id])

        else

          params[params_filter_type.to_sym] = nil

        end

    end

    filters

  end

  def remove_tree_filter_id_from_params(params_filter_id,tree_filter_id)

    if !(params_filter_id.nil?)

      filters_array = params_filter_id.split("|")

      filters_array.delete_if{|i| i.split(">")[1] == tree_filter_id.to_s}.join("|")

    else

      []

    end

  end

    def recommendations
    
    set_type

    set_country

    set_city

    set_area_id_names_generic

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count

          #2012aug08 : Senthil :  commenting the method below, since it sets the params[:query]/@query variable to nil and currently the @query i.e. anything that is entered in the CF search box is very important because in the absence of the view, to recreate the view, the query is used to create the view.

    #set_query_as_nil# This will set the params[:query] as nil, since the user has clicked the suggestions links, it no more sensible to display the searched keyword in the search box

    self.create_instance_variables_for_suggestions_recommendations# create the instance variables that are totally necessary for rendering the result of a click on any suggestions links.

    set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

   #Senthil: The session variables need not be set since the view_name is passed as url from the recommendations links in specific page. This @view_name is set in create_instance_variables_for_suggestions_recommendations method called above.
   # set_session_variables

   #If a view already exists with the same name, this method will drop it.
    Search.drop_temp_view(@view_name)

    self.set_specific_product_id

    set_sub_category_id

    set_sub_category_name(@sub_category_id)

    self.set_feature_id

    self.set_feature

    set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

    @master_hash[@sub_category_id][:final] = Search.fetch_products_list_id_using_feature_id(@feature,@feature_id,@sub_category_name,@specific_product_id,@products_list_id_hash[@sub_category_id])

    Rails.logger.debug "DEBUG-94433-@master_hash..#{@master_hash}" if Rails.logger.debug?

    render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts, FOR ALL THE Subcategories.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

    Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

    render ('search/generic')

  end

#================ Direct Functions - END ================

  # functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def strip_filter_key

    @filter_key = @filter_key.gsub(/[^A-Za-z0-9. ]/," ")

  end


  def create_instance_variables_for_filters

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}# this is declared without being used anywhere because in the view _filters_results.html.erb, .empty? is used to check which needs this variable to be declared. Bad one.

    @sub_category_flag = params[:sub_category_id].to_i# Setting the @sub_category_flag which really important and this keeps the whole filtering process informed about the current sub_category_id.

    @view_name = params[:view_name].to_s# @view_name is set.

    @price_range_final = Hash.new

    @show_filter_tree = 1

  end

  def create_instance_variables_for_suggestions_recommendations

    @hide_suggestions = 1

    set_view_name

    @sub_category_flag = params[:sub_category_id].to_i

    @filter_key = params[:filter_key].to_s

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @products_list_id_hash = Hash.new{|hash, key| hash[key] = Array.new}

    @price_range_final = Hash.new

  end

  def set_feature

    if !(params[:feature].nil?)

      @feature = params[:feature].to_s

    end

  end

  def set_feature_id

    if !(params[:feature_id].nil?)

      @feature_id = params[:feature_id].to_i

    end

  end

  def set_specific_product_id

    if !(params[:specific_product_id].nil?)

      @specific_product_id = params[:specific_product_id].to_i

    end

  end



#================ Auxillary Functions - END ================

end

