class PriceSearchController < GenericPageController
before_filter :form_index_links,:g_hub,:v_top,:o_shops,:p_p_range

    #The back browser button will be busted with a method for search_controller and price_search_controller by calling a before_filter :set_cache_buster. The cached pages wont be used for price_search_controller, every time it will render new pages.
  before_filter :set_cache_buster

# A price search is noting but getting the unique from online/local_grid details and then using that to retrieve the products_list_id and sub_category_id and filling the master_hash only to render a generic search.
# User can choose the sub_category_id and business_type.
#================ DIRECT METHODS START ================

  def index

    @gifts_active_flag = FeaturesMasterValues.where("feature_name = ?",'gifts').select("active_flag").first

    set_sub_categories
    
    set_area_id_names_generic

    set_country
   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count

    form_index_links

  end

  def start_search

    set_sub_categories

   # This will find the number of vendors in the current city
    set_shops_count

   # This will find the number of areas in the current city
    set_areas_count
    
    set_area_id_names_generic

    set_country 

    price_search_index

    if @no_price_results == 1

    @which_page = "noresults"

    write_search_key_in_file

    render ('shared/no_results')

    else

    @which_page = "generic"

    write_search_key_in_file

        render ('search/generic')

    end

  end

#================ DIRECT METHODS - END ================



end

