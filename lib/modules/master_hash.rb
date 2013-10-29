module MasterHash

  include RubyUtilities

  def create_master_hash
  
    @master_hash = Hash.new{|hash, key| hash[key] = Hash.new}
  
    a = @sub_categories.map{|i| i.id }
    
    self.iterate_m_h(a)
    
  end
  
  def iterate_m_h(arr)
  
       arr.each do |i|

          @master_hash[i][:join] = []

          @master_hash[i][:title] = []

          @master_hash[i][:filter] = []

          @master_hash[i][:final] = []

        end
  
  end

  def set_master_hash_from_generic_view(sub_category_id = 0)#method is overridden based on sub_category_id, this is beacuse, sometimes though the generic_view is created for all the sub_categories, only one category details from the view is enough thats exactly when the parameter sub_category_id will be set and in the else condition, the master_hash will be set for only that sub_category_id

   if (@view_name.nil?)

     @view_name = "generic" + request.session_options[:id]

   end

   view_existence = Search.check_view_existence(@view_name)

   if view_existence == "0"

     @from_set_master_hash_from_generic_view = 1

     if @search_case == "products"

        set_raw_key

       #page params from pagination links is set.
        set_page(params[:from_pagination].to_i,params[:page].to_i)

        #preliminary_actions
        create_instance_variables_search# create the instance variables that are totally necessary for the search from home to generic.

        make_search_key_unique#This method forms an array with the raw_key, so every individual word in the query will become the elements of that array. Now, picking up the unique elements in the array and using join to form a string as @literal_search_key.

        #form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

        start_title_filter_searches# starts search in ProductsFilterCollections and FiltersCollections tables.

        order_titles_filters# Now that the master_hash is all set with results, it has to be ordered for relevance. This method does that.

        create_join#This will populate the :join place of the master_hash.

        form_master_hash_final# After populating :filter,:title,:join places of the master_hash the :final place has to be populated and this method does that. Located in application_controller.

        append_title_surface_search_results # 2012aug06 : Senthil : This method will do all the search activities and at last it will find the exact title matches if any and append them to the top of the result set.

     elsif @search_case == "price"

       price_search_index

     end

     Search.create_generic_view(@master_hash,@view_name)#Create the view using the @view_name set before and populate the view with the ids in the master_hash

   end

   if sub_category_id == 0

       @sub_categories.each do |i|

          @master_hash[i.sub_category_id][:final] =  Search.get_products_list_id(@view_name,i.sub_category_id)

        end

   else

     @master_hash[sub_category_id][:final] =  Search.get_products_list_id(@view_name,sub_category_id)

   end

  end

  def form_master_hash_final
    
    @s_c_ids = []

        @master_hash.keys.each do |sub_category_id|
        
              t = @master_hash[sub_category_id][:title].flatten
              
              f = @master_hash[sub_category_id][:filter].flatten
              
              j = @master_hash[sub_category_id][:join].flatten
            
              t1 = t.empty?
              
              f1 = f.empty?
              
              j1 = j.empty?

               if !(t1) && !(f1) && !(j1)

                 @master_hash[sub_category_id][:final] = (j + t ).uniq
                        
               elsif !(t1) && !(f1) && (j1)
               
                 @master_hash[sub_category_id][:final] =  t

               elsif !(t1) && (f1)

                 @master_hash[sub_category_id][:final] =  t

               elsif (t1) && !(f1)

                 @master_hash[sub_category_id][:final] = f

               end
        end


  end




end

