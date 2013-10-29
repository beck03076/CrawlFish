module FilterCategory

   include RubyUtilities
   
   def html_features(a)
   
     a.chomp("N.A").chomp("N.A.").chomp("#").gsub(/#/,", ").gsub(/@/," at ").titleize
   
   end

   def render_categories_filters

          @master_hash.keys.each do |sub_category_id|

            if !(@master_hash[sub_category_id][:final].flatten.empty?)

              self.loop_categories(sub_category_id)

            end

          end
   end

   def loop_categories(sub_category_id)#This method will take sub_category_id as input and form its left-side bar of the generic page. Categories, filters and count.
   
           set_sub_categories(0,0,sub_category_id)
           
           columns = RubyUtilities.m_columns(@sub_category_name)
           
           category = split_x(@sub_category_name,"_",0)          
           
           product_ids = @master_hash[@sub_category_id][:final].flatten

           products_all = model.where(columns[0]+" IN (?) ",product_ids).order(" FIELD "+"("+columns[0]+",#{product_ids.join(",")})").group(columns[2])

           products_all_count = products_all.size.size.to_s
           
           products = products_all.paginate(:per_page => 20, :page => @page)
              
           @price_range_final[@sub_category_id]  = get_price_range(products.flatten.map {|v| v.send(columns[0])},@sub_category_id,@type)       
           
           instance_variable_set("@"+category,products)
           
           instance_variable_set("@"+category+"_all",products_all)
           
           instance_variable_set("@"+category+"_all_count",products_all_count)
           
           self.products_features(category,columns[6].split(","),columns[0],@sub_category_name,products_all,1)
           
   end
   
   def set_columns_category(i)
   
    @sub_category_name = Subcategories.find(i).sub_category_name
  
    columns = RubyUtilities.m_columns(@sub_category_name)
           
    category = split_x(@sub_category_name,"_",0)
    
    [columns,category]
    
    end
   
   
   # The method below is called from both in controller and view for search.
   def products_features(category,
                         features_few,
                         id,
                         sub_category_name,
                         products_all = 0,
                         query = 0 )
                         
        if (products_all != 0)                         
   
          product_ids = products_all.flatten.map {|v| v.send(id)}

        end
        
        @filters_hash =  Hash.new{|hash, key| hash[key] = Array.new}
   
        features_all = select_tables(Regexp.new(category+"_f"))
   
            features_all.each do |full_name|
        
                  features_few.each do |part_name|
                  
                            if full_name.include? "_f"+part_name+"_"
                            
                                      column_names = get_column_names(full_name)
                                      
                                      link_table = "link_" + "f" + part_name + "_" + sub_category_name
                                      just_name = full_name[ /f\d+_[a-z_]+/ ].split("_")[1..-1].join("_")
                                      
                                      filter = "@" + just_name
                                      
                                                                            
                                      filter_type_id = just_name.singularize + "_id"
                                     
                                       
                                       @filters_hash[filter] = [column_names[0],
                                       column_names[1],
                                       link_table,
                                       full_name,
                                       filter_type_id]
                                      
                                      if (query != 0)
                                      
                                        result = General.get_filter_id_name_count(product_ids,
                                        column_names[0],
                                        column_names[1],
                                        full_name,
                                        id,
                                        link_table)
                                      
                                        instance_variable_set(filter,result)
                                      
                                      end
                            
                            end
                  
                   end
         
              end
      
   end
      
   def set_category_order(from_search_controller,clicked = 0)# this method sets the category order, if from_search_controller variable is set to 1, then it sorts the order listing the max number at top. If clicked is set to 1, then clicked_category will be set to sub_category_flag to highlight the current clicked category  

    if !(clicked == 0)

      @clicked_category = @sub_category_flag

    end
    
        count = Hash.new

        @master_hash.keys.each do |i|
        
          size = @master_hash[i][:final].size 
          
          if size != 0
        
             count[i] = @master_hash[i][:final].size
          
          end

        end

        if from_search_controller == 1

          @category_order = count.sort_by {|k,v| v.to_i}.map{|i| i[0].to_i}.reverse

        else

          @category_order = count.map{|i| i[0].to_i}

        end

  end

end

