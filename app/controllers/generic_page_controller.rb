class GenericPageController < ApplicationController

  include PriceSearch

  include ProductSearch

  include FilterCategory

  include MasterHash

  include SearchModule

  protected

   # functions defined after this section are direct
#================ Direct Functions products search- START ================

  def generic_search_index

        #session[:user_key] = "currentuser"

        set_session_variables#In this, all the session variables are being set, mainly the session id is concatenated with "generic" which will be used for this sessions view name.

        session[:query] = @raw_key

        set_generic_meta_tags#2012jul12 added this function and is defined in application controller to set meta tags for generic page dynamically

        if params[:view_name].nil?

          @view_name = session[:generic_view_name]

        else

          @view_name = params[:view_name].to_s

        end

        set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

        #page params from pagination links is set.
        set_page(params[:from_pagination].to_i,params[:page].to_i)        

        set_sub_categories#called from application_controller, this will set the @sub_categories variable with all the records in Subcategories table.

        create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

        if @from_set_master_hash_from_generic_view == 1

          start_search#starts all the activities for a search.

        elsif params[:from_pagination].to_i == 1 && !(@sub_category_flag.nil?)

          start_paginate#a request has arrived from pagination links, so this time lets not search anything, instead use the view created by the generic search.

        else

          start_search#starts all the activities for a search.

        end

  end


  def start_search

    #preliminary_actions
    create_instance_variables_search# create the instance variables that are totally necessary for the search from home to generic.

    #If a view already exists with the same name, this method will drop it.
    Search.drop_temp_view(@view_name)

    make_search_key_unique#This method forms an array with the raw_key, so every individual word in the query will become the elements of that array. Now, picking up the unique elements in the array and using join to form a string as @literal_search_key.

    start_generic_search#find below the list of things done by this method.
    #1. set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.
    #2. Calls start_title_filter_searches, which will search the query in ProductsFilterCollections and FiltersCollections tables
    #3. Calls order_titles_filters which rank the results based on no of occurences for relevance.
    #4. Calls create_join which will populate the :join place of master_hash.
    #5. Calls form_master_hash_final, after ordering for relevance, this method populates the :final place of master_hash which will be displayed on the page.
    #6. Call get_key_of_max_value_count a method in ruby_utilities module to find the max number of categories
    #7. Calls render_categories_filters which is in application_controller responsible for forming the left side bar of the generic page, filters, categories and counts.
    #8. Check no_books_flag and no_mobiles_flag and render no results page or generic page.

  end

  def start_paginate

    create_instance_variables_paginate# create the instance variables that are totally necessary for the pagination in generic page.

    set_master_hash_from_generic_view(@sub_category_flag)# The master_hash which was created in the create_instance_variables method will be set from the generic_view based on the data present in the view_name procured from the url parameter as params[:view_name]

    loop_categories(@sub_category_flag)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count. Located in application_controller, FOR ONLY THE CURRENT Subcategory.

    set_category_order(0,1)# This method is called from application_controller, decides which category has to be listed first.

  end

  #================ Direct Functions products search - END ================

  #================ Direct Functions for price_search- Start ================

  def price_search_index

    create_instance_variables_price# this method creates the necessary instance variables for price_search which actually renders generic search page.

    set_sub_categories# called from application_controller, sets @sub_categories with all available categories

    create_master_hash# create the @master_hash which is very important for search and it holds books_list_id and mobiles_list_id of part-2 after searching in 4 places, :join, :filter, :title, :final for all the subcategories.

    set_session_variables#In this, all the session variables are being set, mainly the session id is concatenated with "generic" which will be used for this sessions view name.

     set_page(params[:from_pagination].to_i,params[:page].to_i)# called from application_controller, this is set the @page variable which handles pagination navigations.

    set_search_case#this method is called from application_controller, it sets the instance variable @search_type from params.

    set_generic_view_name#@view_name is set from session[:generic_view_name]

    set_price_query_type_sub_category_id#these are very important params from the form of the price search. they are set as instance variables in this method. price_query, sub_category_flag, type.

    if (validate_price_query_set_unique_ids)# validates the price_query and sets the @unique_ids variable by calling next level auxillary methods.

     @no_price_results = 1

    else

        set_products_list_id_sub_category_id# from @unique_ids array the @products_list_id_sub_category_id is set by doing a mysql select on link_products_lists_vendors

        if fill_master_hash#a simple iteration on the array created in the previous step is done and @master_hash is filled up.

          render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts.

          set_category_order(1)# This method is called from application_controller, decides which category has to be listed first.

          Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

          set_price_finder_meta_tags#2012jul12 - defined in application controller. This function initializes meta tags

        else

      @no_price_results = 1

        end

    end

  end

  #================ Direct Functions for price_search- End ================

# functions defined after this section are used for search both in regular search and price search
#================ Auxilary methods ================

  def form_products_list_id_hash

    @master_hash.keys.each do |sub_category_id|

      @products_list_id_hash[sub_category_id] = LinkProductsListsVendors.get_products_list_id(sub_category_id)

    end

  end

  def set_page(from_pagination,page)

     if !(from_pagination.nil?)

      if from_pagination.to_i == 1

        @page = page

      else

        @page = 1

      end

    end

   end

  def order_products_id(actual)

        actual.flatten.group_by{|x| x}.sort_by{|k, v| -v.size}.map(&:first)

  end

  def set_session_variables

	    #below changes were done on 2012jul22 to handle nil case of session[:current_id]
	    session[:current_id] = request.session_options[:id]

	    if(!session[:current_id].nil?)

		    session[:generic_view_name] = "generic"+session[:current_id]

	    else

		    session[:session_id]
		    session[:current_id] = request.session_options[:id]
		    session[:generic_view_name] = "generic"+session[:current_id]

	    end

	    session[:order] = 0

  end

  def write_search_key_in_file

	if(!File.exist?("public/search_logs/"+Date.today.to_s+"/"))

		FileUtils.mkdir_p("public/search_logs/"+Date.today.to_s+"/")

    	end

        if (@which_page.nil?)
		@which_page = "undefined"
        end

	search_log_session_id = request.session_options[:id]

	if !(session[:query].nil?)

      		if(File.exist?("public/search_logs/"+Date.today.to_s+"/"+search_log_session_id+'.dat'))
	    		File.open("public/search_logs/"+Date.today.to_s+"/"+search_log_session_id+'.dat', 'a') {|f| f.write(session[:query].to_s + "|" + @which_page + "\n") }
    		else
    	    		File.open("public/search_logs/"+Date.today.to_s+"/"+search_log_session_id+'.dat', 'a') do |f|
		 	f.write(Time.new)
		 	f.write("\n" + session[:query].to_s + "|" + @which_page + "\n")
	    		end
    		end
	end
  end

#================ Auxillary methods end ================

end

