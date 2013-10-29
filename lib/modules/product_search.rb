module ProductSearch

  # functions defined after this section are auxillary
#================ Auxillary Functions - START ================


  def set_raw_key

    if @raw_key.nil?

      if !(params[:query].nil?)

        @raw_key = params[:query].to_s

      end

    end

  end

  def append_title_surface_search_results

    @master_hash = ProductsFilterCollections.surface_search(@master_hash,
                              make_sphinx_search_key(@literal_search_key,
                                                              "surface"))#This will search for titles in the query against ProductsFilterCollections in plus mode. Plus mode is nothing but all the words in the document should be matched with one or more words in the query.

  end

  def create_instance_variables_paginate

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}# this is declared without being used anywhere because in the view _filters_results.html.erb, .empty? is used to check which needs this variable to be declared. Bad one.

    @price_range_final = Hash.new

  end

  def create_instance_variables_search

    @no_results_flag = 0

    @matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

    @products_list_id_hash = Hash.new{|hash, key| hash[key] = Array.new}

    @unmatched_title_keys = [ ]

    @exact_title_and_filter_flag = 0

    @price_range_final = Hash.new

    FiltersCollections.flush_matched_filter_keys

    ProductsFilterCollections.flush_unmatched_title_keys

  end

  def unarticle_search_key

    temp = @literal_search_key.split(" ")

    if temp.size > 1

    @unarticled_search_key = (temp - []).join(" ")

    else

    @unarticled_search_key = @literal_search_key

    end

    @unarticled_search_key

  end

  def remove_re_search_if_exact

        matched_filter_keys = FiltersCollections.get_matched_filter_keys

        FiltersCollections.flush_matched_filter_keys

        @literal_search_key = (@literal_search_key.split(" ") - matched_filter_keys.values.flatten.uniq.join(" ").split(" ")).join(" ")

  end

  def start_title_filter_searches
  
     ans = self.s(ProductsFilterCollections,@literal_search_key) 
     @master_hash = self.g("title",@master_hash,ans)

     if !check_deep_search_plus(@master_hash,"title")
     
        ans = self.s(ProductsFilterCollections,@literal_search_key,{:match_mode => :any}) 
        @master_hash = self.g("title",@master_hash,ans)
        
        if !check_deep_search_plus(@master_hash,"title")
            ans = self.s(FiltersCollections,@literal_search_key) 
            @master_hash = self.g("filter",@master_hash,ans)
            
            if !check_deep_search_plus(@master_hash,"filter")
            
                ans = self.s(FiltersCollections,@literal_search_key,{:match_mode => :any}) 
                @master_hash = self.g("filter",@master_hash,ans)
            end
        end
    end
    
    
    
  end
  
  def s(obj,key,opts = {})
  
    opts[:limit] = 1000000
    
    obj.search key, opts
  
  end
  
  def g(type,m,ans)
    
    out = ans.compact
    
    if !out.blank?
        out = out.group_by(&:sub_category_id)

        out.keys.each do |i|
         m[i][type.to_sym] = out[i].map{|i| i.filter_id}
        end
    end
    m
  end

  def start_generic_search

          form_products_list_id_hash# Called from application_controller,set products_list_id_hash retrieved from link_products_lists_vendors, this is because, the table link_products_lists_vendors has the products_list_ids present in part-1, crawlfish currently does a part-1 search.

          start_title_filter_searches# starts search in ProductsFilterCollections and FiltersCollections tables.

          order_titles_filters# Now that the master_hash is all set with results, it has to be ordered for relevance. This method does that.

          create_join#This will populate the :join place of the master_hash.

          form_master_hash_final# After populating :filter,:title,:join places of the master_hash the :final place has to be populated and this method does that. Located in application_controller.

        x = @products_list_id_hash
        m = @master_hash
        x.keys.each do |i|        
          m[i][:final] = m[i][:final] & x[i]
        end
        @master_hash = m
        
        p "***********************"
        p @master_hash
  end

  def make_search_key_unique

    if !(@raw_key.nil?)

      @literal_search_key =  @raw_key.split(" ").uniq.join(" ").downcase

    end

  end

  def make_sphinx_search_key(search_key,type,from = 0)

    if !(search_key.nil?)

      search_key_unique = search_key.gsub(/[^A-Za-z0-9 ]/," ").squeeze(" ").split.uniq# please note the space in the gsub pattern which is very very important, do not remove it ever

        search_key_string = search_key_unique.join(" ")

        if type == 'surface'

          search_key_size = search_key_unique.size

          sphinx_search_key =  "\"#{search_key_string}\"/#{search_key_size}"

        elsif type == 'deep'

          sphinx_search_key =  "\"#{search_key_string}\"/1"

        end

        sphinx_search_key

    end

  end

  def order_titles_filters

    @master_hash.keys.each do |i|
    
      t = @master_hash[i][:title].flatten
      
      t1 = t.empty?
      
      f = @master_hash[i][:filter].flatten
      
      f1 = f.empty?

      if !(t1)

        @master_hash[i][:title] = order_products_id(t)

      end

      if !(f1)

        if (t1)

            @master_hash[i][:filter] = order_products_id(@master_hash[i][:filter])

        end

      end

    end

  end

  def create_join
  
     @master_hash.keys.each do |sub_category_id|
     
       t = @master_hash[sub_category_id][:title].flatten
     
       t1 = t.empty?
     
       f = @master_hash[sub_category_id][:filter].flatten
     
       f1 = f.empty?

       if !(t1)  && !(f1)

         @master_hash[sub_category_id][:join] = order_products_id(t + f)

       end

     end

   end

  def order_products_id(actual)

        actual.flatten.group_by{|x| x}.sort_by{|k, v| -v.size}.map(&:first)

  end

#================ Auxillary Functions - END ================

#================= Generic Search ================================

end

