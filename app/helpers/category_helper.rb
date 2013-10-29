module CategoryHelper

  include RubyUtilities
  
  include FilterCategory

# functions defined after this section are direct
#================ Direct Functions - START ================

  def create_category_tabs(final_counts)
  
   order = final_counts.sort_by {|k,v| v.to_i}.map{|i| i[0].to_i}.reverse
   
   html = '<div style="padding-top:15px;"></div>'       
      
   order.each do |i|
   
             html = html + '<div class="cf-generic-category-tabs-mobiles"> <div class="cf-gct-products-header">'
             
             html = html + decide_category_order(i,1,i)
             
             html = html + '<div class="comments-text">
             Listing the first 2 results of this category, click below to view all results!
              </div>'
             
             html = html + '<div style="padding-top:8px;padding-bottom:5px;padding-left:2px;padding-right:20px;"><div style="border:1px solid #999;"></div> </div>'

         html = html + '<div class="cf-gct-products-outer-container">'
             
             temp = set_columns_category(i)
             
             products = eval("@"+temp[1])
             
             columns = temp[0]
             
             category = temp[1]
             
             @sub_category_flag = i
             
             @category_name = Subcategories.find_by_sub_category_id(i).category_name
             
             if !(products.nil?)
             
               products.take(2).each do |product|
               
                 price_range_final,price_type = form_price_range_final_text(@price_range_final,i,product.send(columns[0]))
                 
                 html = html + '<div class="cf-gct-products-inner-container">'

         html = html + '<div>' 
         
         img = product.send(columns[4]).split(",")[1].to_s
         
                 html = html + form_generic_to_specific_page_links("image",
                                                             img,
                                                             @type,
                                                             @category_name,
                                                             product.name_slug,
                                                             product.identifier_slug,
                                                             @country,
                                                             @current_city.city_name,
                                                             @areas)
                                                             
                 html = html + '</div>'

         html = html + '<div class="cf-gct-products-inner-container-name">'
                 
                 html = html + form_generic_to_specific_page_links("link",
                                                             product.send(columns[2]),
                                                             @type,
                                                             @category_name,
                                                             product.name_slug,
                                                             product.identifier_slug,
                                                             @country,
                                                             @current_city.city_name,
                                                             @areas)
                                                             
                 html = html + '</div>'

         html = html +'<div class="cf-gct-products-inner-container-price>'
                  
                 if !price_range_final.nil? || !price_type.nil?
                 
                   html = html + decide_price_range_starts_at(price_range_final,
                                                              price_type)
                                                              
                 else
                 
                   html = html + '<span class="list-price-range-details"><b> Starts at: </b> N.A.</span>'
                  
                 end
                 
                 html = html + '</div></div>'
                 
                 end
                 
                end
                 
                 html = html + '<div style="clear:both"></div>'
                 
                 html = html + '<div class="cf-gct-products-inner-container-button padT10 padL40">'
                 
                 html = html + link_to("View all "+category.titleize,
                               {:controller => 'category', 
                               :action => 'switch',
                               :sub_category_id => @sub_category_flag, 
                               :query => @query, 
                               :view_name => @view_name, 
                               :search_case => @search_case, 
                               :price_query => @price_query, 
                               :type => params[:type], 
                               :city => params[:city], 
                               :multiple_area_ids => params[:multiple_area_ids],
                               :country => params[:country]},
                               :class=> "cf-gct-picb-link",:rel => 'nofollow')
                               
                html = html + '</div></div></div></div>'
                        
            end
            
            html.html_safe

  end

  def decide_category_order(sub_category_id,index,sub_category_flag = 0,image_type = 0)
  
    sub_category_name = Subcategories.find_by_sub_category_id(sub_category_id).sub_category_name

    if sub_category_flag == 0

      self.set_html_class(index)

    else

      if sub_category_id == sub_category_flag

        self.set_html_class(0)

      else

         self.set_html_class(1)

      end

    end
    
    self.set_instance_variables(sub_category_id)
    
    category = split_x(sub_category_name,"_",0)

    @count = eval("@"+category+"_all_count")

    if !(@count.to_i == 0)   

      self.set_and_return_html(sub_category_id,image_type)

    end

  end

  def form_clicked_category

    if !(@clicked_category.nil?)

      self.set_html_class(0)

      self.create_instance_variables(@sub_category_flag)

      self.create_instance_variables(@sub_category_flag)

      self.set_and_return_html(@sub_category_flag)

    end

  end

  def form_image_name_elements(image_url,name,html_hash = {})

    html_options = {}

     html_options = {:controller => 'specific',:action => 'specific_search', :specific_product_id => specific_product_id, :sub_category_id => sub_category_flag, :price_range => price_range_final,:search_case =>search_case, :view_name => view_name, :anchor => anchor_name,:rel => 'nofollow' }

     html = link_to image_tag(element),html_options,html_hash

     html

  end

#================ Direct Functions - END ================


# functions defined after this section are auxillary
#================ Auxillary Functions - START ================

  def set_instance_variables(sub_category_id)
   
    @sub_category_flag ||= sub_category_id
   
      @sub_categories.each do |i|
    
              category = split_x(i.sub_category_name,"_",0)
            
              temp1 = "@"+category+"_all_count"
              
              temp2 = category+"_all_count"
              
              temp3 = temp2.to_sym
              
              temp4 = params[temp3].to_i
      
              if eval(temp1).nil?
                 # Ruby inbuilt method to set values to an instance variable
                 instance_variable_set(temp1,temp4)
                
              end
       end

  end

  def set_and_return_html(sub_category_id,image_type = 0)

    if image_type == 0

      self.form_category_link_or_image(sub_category_id)

    else
    
      @sub_categories.each do |i|
      
        if image_type == i.sub_category_name
        
          self.form_category_link_or_image(sub_category_id,i.category_name,"/Images/CF_logoChart_v1.png")
          
        end
       
       end
       
     end  
     
  end

  def form_category_link_or_image(sub_category_id,category = 0,image_url = 0)
  
    s = (@sub_categories.index_by &:sub_category_id)[sub_category_id].category_name.titleize

    params_hash = {:controller => 'category',
                   :action => 'switch',
                   :sub_category_id => sub_category_id,
                   :query => @query,
                   :view_name => @view_name,
                   :search_case => @search_case,
                   :price_query => @price_query,
                   :type => params[:type],
                   :city => params[:city],
                   :multiple_area_ids => params[:multiple_area_ids],
                   :country => params[:country]}

    if image_url == 0

      link_to (s +" ["+@count.to_s+"] "), params_hash,{:id => sub_category_id,:class => @html_class,:rel => 'nofollow'}

    else

      html1 = link_to image_tag(image_url), params_hash,{:id => sub_category_id,:class => @html_class,:rel => 'nofollow'}

      html2 = link_to (s +" ["+@count.to_s+"] "), params_hash,{:id => sub_category_id,:class => @html_class,:rel => 'nofollow'}

      html1 + html2

    end

  end

  def set_html_class(index)

    if index == 0

      @html_class = "active_category"

    else

      @html_class = "inactive_category"

    end

  end

#================ Auxillary Functions - END ================

end

