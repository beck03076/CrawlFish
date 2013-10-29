class SearchController < GenericPageController
 before_filter :set_cache_buster,:form_index_links,:g_hub,:v_top,:o_shops,:p_p_range,
               :except =>[:viewed]


  include SearchModule
  
  include RubyUtilities

  def index
   
    set_sub_categories
    
    #set the value of @sub_category_flag from params[:sub_category_id]
    set_sub_category_flag

    set_type

    set_country

    set_city

    set_area_id_names_generic    

    @raw_key = params[:query].strip

    send_to_specific_if_exact_product_name(@raw_key)

    if @no_exact_results_flag == 1

      proceed_with_generic_page      

    else

      self.decide_specific_or_generic_page

    end

  end

  def proceed_with_generic_page

    if validate_searchkey(@raw_key)

              generic_search_index# Called from generic_page_controller

              render_categories_filters# Called from application_controller, forms the left-side bar of generic page with filters and their counts.

              @matched_filter_keys = FiltersCollections.get_matched_filter_keys# this is a method in the model FiltersCollections to retrieve the words in the query which matched as a filter during FiltersCollections search.

              set_category_order(1)# This method is called from filter_category.rb module, decides which category has to be listed first.
              
              @size = 0

              @master_hash.keys.each do |i|
              
                @size = @size + @master_hash[i][:final].flatten.size
                
              end
              
              if (@size == 0)# check whether there are results 

                 @message = "No results fetched!"

             #added this on 2012aug02 to write search_logs

                 @which_page = "noresults"

                 write_search_key_in_file

                 render ('shared/no_results')

              else

                Search.create_generic_view(@master_hash,@view_name)

                @final_search_key = @literal_search_key

                @which_page = "generic"

                fetch_ad_list_details("generic",0)

                 #added this on 2012aug02 to write search_logs
                write_search_key_in_file
                
                render 'generic'

              end

    else

      @which_page = "noresults"

      write_search_key_in_file

      render 'shared/no_results'

    end

  end
  
  def viewed
     @res = Hash.new{|hash, key| hash[key] = Array.new}
     p = params[:ids].split(",").uniq
     
     h = Hash.new{|hash, key| hash[key] = Array.new}
     p.map{|i| h[i.split("|")[1]] << i.split("|")[0]}

     h.keys.each do |k|

         obj = Subcategories.find(k)
         s_c = obj.sub_category_name
         c = obj.category_name
         cols = RubyUtilities.m_columns(s_c)
         key = c + "|" + cols[2] + "|" + cols[4] 
         @country ="india"
         
         @res[key] = s_c.camelize.constantize.where(cols[0].to_sym => h[k])
         
     end
     
     render :partial => "shared/viewed"

  end


#================ Auxillary Functions - END ================

  def decide_specific_or_generic_page

    if @specific_flag == 1

      redirect_to_specific_page(@type,
                               @category_name,
                               @product_name,
                               @country,
                               @current_city.city_name,
                               @areas)

    elsif !(@specific_flag == 1)

        proceed_with_generic_page

    end

  end

  def specific

  end

  def generic

  end

  def exception

  end

end

