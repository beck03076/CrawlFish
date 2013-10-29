module FilterHelper

  include FilterCategory

  def create_filters_hash(i)
  
             # This method is called from filter_category.rb, sets, @sub_category_name, category, columns
    result = set_columns_category(i)
    
    columns = result[0]
    
    category = result[1]

    File.open("public/search_logs/"+Date.today.to_s+"/"+"logs"+'.dat', 'a') do |f|
        f.write(columns[0] + "\n")
        f.write(columns[6].split(",").to_s + "\n")
        f.write(category + "\n")
        f.write("\n")
    end

    #This method is called from Module filter_category.rb, this sets the array, @filter_hash with the filters instance variables to show
    products_features(category,columns[6].split(","),columns[0],@sub_category_name)

  end
  
  def iterate_filters_hash(i,feature_id,feature_name,link_table,feature_model,feature_type)
  
        title = i[1..-1].titleize
      
        @feature = eval(i)
        
        if !@feature.nil?
        
         if @feature.count > 0 
         
          html = '<div class="'+title+'_filters">'
         
          html = html + '<div class="cf-generic-left-sidebar-filter-heading"><h2>'+title+'</h2></div>'
          
          html = html +'<ul class="cf-generic-left-sidebar-filter-links-ul">'
          
                  @feature.each do |j| 
                  
                   html = html + '<li>'                   
                   
                   html = html + self.form_filter_url(j,
                                                      params[feature_id.to_sym],
                                                      params[:order],
                                                      feature_name,
                                                      feature_id,
                                                      "filters",
                                                      @sub_category_flag,
                                                      link_table,
                                                      feature_model,
                                                      feature_type)
               
                   html = html + '</li>'
                  
                  end
          
          html = html + '</ul>' + '</div>'
          
          html.html_safe
          
          end
          
           
           
         end
         
        
  end

  def form_filter_url(filter,
                          params_filter_id,
                          params_order,
                          filter_name,
                          filter_id,
                          action,
                          sub_category_id,
                          link_table,
                          feature_model,
                          feature_type)
#form_filter_url(genre,params[:genre_id],params[:order],"genre_name","genre_id","filters",@sub_category_flag)

            #This method is called from filter_category module, which decorates the raw feature from the DB and makes it html friendly
    title = html_features(truncate(filter[1],:length => 22))+" ["+filter[2].to_s+"] "

       if !(filter[1].downcase.gsub(/\./,"").gsub(/ /,"").chomp == "na")

         if filter[1].length > 1

           if !(params_order.nil?)

                if (params_filter_id.nil?)
                
                  order = params_order.to_i+1
                  
                  id = (params_order.to_i+1).to_s+'>'+filter[0].to_s 

                else
                
                  order = params_order.to_i+1
                  
                  id = params_filter_id.to_s+'|'+(params_order.to_i+1).to_s+'>'+filter[0].to_s 

                end

           else
           
             order = 0
             
             id = '0'+'>'+filter[0].to_s

           end
           
           order = params_order.to_i+1
             
           id = (params_order.to_i+1).to_s+'>'+filter[0].to_s

         end
         
       end
       
       link_to (title), params.merge({:controller => 'filter',
                                      :action => action,
                                      :sub_category_id => sub_category_id,
                                      :view_name => @view_name,
                                      :query => params[:query],
                                      :from_pagination => 0,
                                      :order => order,
                                      feature_type.to_sym => [id,
                                                              link_table,
                                                              feature_model]}),:rel => 'nofollow' 

    end

    def form_cross_url(filter_type,
                       filter_id,
                       order,
                       sub_category_id,
                       tree_filter_id)

      #form_cross_url("binding_id",params[:binding_id],params[:order],@sub_category_flag,tree_filter_id)

       html = link_to ("x"), params.merge({:controller => 'filter',
                                           :action => 'cross_filters',
                                           :sub_category_id => sub_category_id,
                                           :from_pagination => 0,
                                           :view_name => @view_name,
                                           :query => params[:query],
                                           :order => order.to_i,
                                           filter_type.to_sym => filter_id,
                                           :tree_filter_id => tree_filter_id,
                                           :filter_type => filter_type.to_s}),
              {:style => "color:#000; text-decoration:none",:rel => 'nofollow'}

       html

    end

   def create_sub_category_box(sub_category_id)
      
#Commented out, it is to give links to the tree boxes
#<a href="" STYLE="text-decoration:none;">
         html =  '<span style="border:1px solid #E0E0E0;color:#444;position:relative;bottom:4px;background:#EEE;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;">'


             html = html + @sub_categories.select{|i| i.sub_category_id == @sub_category_flag}.map {|i| i.category_name}.join.capitalize

             html = html + '</span>'

             html + '<span style="color:#6E6A6B;size=2;position:relative;bottom:4px;background:#FFFFF;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;"></span>'

   end
 
    # a lot of CSS should be implemented to shorten this method and follow good practices
   def create_tree_box(model_name,method_name,filter_type,tree_filter_id,order,filter_id)
   
     html =  '<span style="border:1px solid #E0E0E0;color:#444;position:relative;bottom:4px;font-weight:bold;background:#EEE;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;">'
                 
     feature = modelize(model_name).send(method_name,
                                         tree_filter_id).join
                                         
                               #This method is called from filter_category module, which decorates the raw feature from the DB and makes it html friendly
     html = html + html_features(feature)
     html = html + '</a> <span style="position:relative;bottom:1px;">'

     link = self.form_cross_url(filter_type,
                                filter_id,
                                order,
                                @sub_category_flag,
                                tree_filter_id)

     html = html + link

     html = html + '</span>
     </span>'

     html + '<span style="color:#6E6A6B;size=2;position:relative;bottom:4px;background:#FFFFF;padding-top:2px;padding-left:2px;padding-right:2px;padding-bottom:2px;"></span>'

   end
     

   def parse_params(params,tree_flag = 0)
    
        big_params = Array.new

        params.keys.each do |i|

          if params[i].kind_of?(Array)
          
            filter_id = params[i][0]
            link_table = params[i][1]
            model = params[i][2]
            
            temp_array = [ ]
            temp_array = filter_id.split("|")
            final_big_param = Array.new
            
            temp_array.each do |temp|
            
              big_param = Hash.new
              
              big_param[:feature_type_id] = i.to_s                          
              big_param[:order] = temp.split(">")[0]
              big_param[:id] = temp.split(">")[1]

              if tree_flag == 0

                big_param[:link_table_name] = link_table
                big_param[:feature_model_name] = model
                big_param[:filter_id] = filter_id
                            
              end

                 final_big_param << big_param
           end
                  
           big_params << final_big_param.uniq {|e| e[:id] }

         end

        end        

        big_params.flatten.sort_by {|i| i[:order].to_i}

   end

    def form_suggestions_links

      html = '<div class="cf-generic-right-sidebar-srch-suggestion">
              <div class="cf-right-sidebar-matched-filter-results">
          <div class="cf-right-sidebar-matched-filter-mascot-img"><div style="border-bottom:1px solid #999;"><img src="/Images/Mascots/cf_suggestions.jpg" alt="SUGGESTIONS" title="Suggestions"> </div></div>
              <div class="cf-right-sidebar-matched-filter-results-heading"><span style="font-size:13px;line-height:20px">Use <span style="font-weight:bold;color:#C42525">Suggestions</span> to find quick answers!</span></div>'
    
        @matched_filter_keys.keys.each do |sub_category_id|

            html = html + '<ul class="cf-right-sidebar-matched-filter-results-ul">'

                        group_suggestions_filter(@matched_filter_keys[sub_category_id]).each do |i|

                              i.keys.each do |j|

                          html = html + '<div style="padding-top:5px;">'

                                      html = html + '<div class="cf-right-sidebar-matched-filter-heading"> <div class="cf-rsmfh-text">'

                                      html = html + strip_filter_name(j)

                                      html = html + '</div></div>'

                                      html = html + '<div style="padding-top:5px;">'

                                         i[j].each do |k|

                                                  html = html + '<li class="cf-right-sidebar-matched-filter-results-li">'

                                                                                                                         html_link = link_to (k.titlecase), {:controller => 'filter', 
                                                 :action => 'suggestions', 
                                                 :sub_category_id => sub_category_id, 
                                                 :filter_key => k,
                                                 :view_name => @view_name, 
                                                 :query => params[:query],
                                                 :search_case => @search_case,
                                                 :country => params[:country],
                                                 :city => params[:city],
                                                 :area => params[:area]  },{:rel => 'nofollow'}

                                                  html = html + html_link

                                                  html = html + '</li>'

                                         end

                              end

                        end

            html = html + '</ul>'
        
        end            

      html = html + '</div>
             </div>'

      html.html_safe

    end

    def group_suggestions_filter(element)

      element.group_by{|j| j[1]}.map{|k,v| {k => v.map{|i| i[0]}.uniq} }

    end

    def strip_filter_name(name)

      puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--name is => #{name}"


      tmp = name.split("_")

      if tmp.include?("list")

        tmp = self.change_list_to_index(tmp)

      end

      puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&-- tmp is =>#{tmp}"

      tmp.take(tmp.size - 1).join(" ").titlecase

    end

    def change_list_to_index(array)

      array.map{|e| e == "list" ? "index" : e }

    end

end

