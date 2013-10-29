module PriceSearch

  # functions defined after this section are auxillary -1 methods used by direct methods.
#================ AUXILLARY- 1 - START ================

  def set_generic_view_name

    if !(session[:generic_view_name].nil?)

      @view_name = session[:generic_view_name]

    else

      error_log("session[:generic_view_name] was nil",2)

    end

  end

  def create_instance_variables_price

    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @price_range_final = Hash.new

    @products_list_id_sub_category_id = []

    @unique_ids = []

  end

  def set_price_query_type_sub_category_id

    if !(params[:price_query].nil?)

      @price_query = params[:price_query]

    else

        error_log("params[:price_query] was empty")

    end

    if !(params[:type].nil?)

      self.set_type_from_params_type

    else

        error_log("params[:type] was empty")

    end

    if !(params[:sub_category_id].nil?)

      @sub_category_id_params = params[:sub_category_id].to_i

    else

      @sub_category_id_params = 0

    end

  end

  def validate_price_query_set_unique_ids

    if validate_searchkey(@price_query)

      if !(self.strip_price_query)

        return false

      end

      self.set_gap_unique_ids

      if !(self.set_unique_ids)

        return false

      end

    end

  end

  def set_products_list_id_sub_category_id

    if !(@unique_ids.empty?)

     @products_list_id_sub_category_id = LinkProductsListsVendors.get_products_list_id_sub_category_id_from_unique_id(@unique_ids,@sub_category_id_params)

     else

        error_log("@unique_ids was empty")

    end

  end

  def fill_master_hash

    if !(@products_list_id_sub_category_id.empty?)

        @products_list_id_sub_category_id.each do |i|

          @master_hash[i.sub_category_id][:final] << i.products_list_id

        end

        return true

    else

        error_log("@products_list_id_sub_category_id was empty")

        return false

    end

  end

#================ AUXILLARY- 1 - END ================

#These methods are used by auxillary - 1 methods
#================ AUXILLARY- 2 - START ================

  def strip_price_query

    @price_query = @price_query.gsub(/,/,"").scan(/[0-9].+/).join.to_i

    if @price_query == 0

      return false

    else

      session[:query] = @price_query

      return true

    end

  end

  def set_gap_unique_ids

    @unique_ids = []

    for i in (0..9)

       if @price_query.between?(i * 1000,(i + 1)  * 1000)

         @gap = (((i + 1)  * 100)/2).to_i

         return

       else

         @gap = 1000.to_i

       end

    end

  end

  def set_unique_ids

    counter = 1

    while (@unique_ids.empty?) do

       @unique_ids =  General.get_unique_id_between_given_price(@price_query,@gap,@type)

       self.increase_gap

       counter = counter + 1

       if counter == 5

         return false

       end

    end

  end

  def set_type_from_params_type

    params_type = params[:type].to_i

      if params_type == 0

        @type = "online"

      elsif params_type == 1

        @type = "local"

      end

  end

#================ AUXILLARY- 2 - END ================

#These methods are used by auxillary - 2 methods
#================ AUXILLARY- 3 - START ================
  def increase_gap

    @gap = @gap + 50

  end
#================ AUXILLARY- 3 - END ================

end

