module SearchHelper

  include RubyUtilities
  
  include FilterCategory
  
  def create_products_results(i)  
  
    # This method is called from filter_category.rb, sets, @sub_category_name, category, columns
    result = set_columns_category(i)
    
    columns = result[0]
    
    category = result[1]
    
    short = category.chomp("s")
    
    v_products = eval("@"+category)
    
    html =  '<table class="list" cellpadding="10px" cellspacing="0px">'
    
    paginate = will_paginate(v_products, :params => {:from_pagination => 1,
                       :view_name => @view_name ,
                       :sub_category_id => i})    

    v_products.each do |product|
    
      product_id = product.send(columns[0])
    
      product_avl = self.set_product_avl(product_id,
                                         model,
                                         columns[0],
                                         columns[7])
                                         
      price_range_final,price_type = form_price_range_final_text(@price_range_final,
 i,
 product.send(columns[0])) 
 
       html = html + '<tr class="list_tr"> <td class="image_record">'
       
       img = product.send(columns[4]).split(",")[1].to_s
       
        if product_avl == "y"
      
           html = html + form_generic_to_specific_page_links("image",
                                                     img,
                                                     @type,
                                                     @category_name,
                                                     product.name_slug,
                                                     product.identifier_slug,
                                                     @country,
                                                     @current_city.city_name,
                                                     @areas)
                                                     
                                                     puts 

        else
        
           html = html + image_tag(img, :alt => product.send(columns[2]), :title => product.send(columns[2]))
        
        end
      
        html = html + '</td>'        

        html = html + '<td class="product_table_data">' 
     
        html = html + '<span class="red-link-15-b">' 

        if product_avl == "y"
      
           html = html + form_generic_to_specific_page_links("link",
                                                     product.send(columns[2]),
                                                     @type,
                                                     @category_name,
                                                     product.name_slug,
                                                     product.identifier_slug,
                                                     @country,
                                                     @current_city.city_name,
                                                     @areas)

        else
        
           html = html + product.send(columns[2])
        
        end
        
        html = html + "</span>
        <div class='comments-text'> You are about to view, #{@type == 'local' ? 'Retail' : 'Online'} shops for this product!
        <div>
        <br/>"
        
        feature = short + "_features"
        
        features = product.send(feature).split("#")
        
        p "((((((((((((()))))))))))))"
        p features
        
        list = columns[8]
          html = html + '<ul class="w200">'
          list.keys.each do |j|
          
              html = html + self.form_features(j,list[j],features)
                          
          end
          html = html + '</ul>'
       
        html = html + '<div class="cf-gct-products-inner-container-price">'
                  
                 if !price_range_final.nil? || !price_type.nil?
                 
                   html = html + decide_price_range_starts_at(price_range_final,
                                                              price_type)
                                                              
                 else
                 
                   html = html + '<span class="list-price-range-details"><b> Starts at: </b> N.A.</span>'
                  
                 end
                 
        html = html + '</div>'

        html = html + '</td></tr>'
        
        
    end
    
    html = html + '</table>'
    
    html = html + ''

        if !(paginate.nil?)
    
          html = paginate + html.html_safe + paginate
      
        end
                       
        html.html_safe
  
  end
  
  def form_features(no,display,features)
  
   html = '<li class="feature'+(no.to_i).to_s+'">'

   
    html = html + self.set_generic_page_features(features[no],display)
   
   
   html + '</li>'
     
  end
  
  def plurals(no,word,html)
  
    if no == 1
    
      word = word
      
    elsif no == 0
      
      word = word.pluralize
      
    elsif no > 1
      
      word = word.pluralize 
      
    end
    
    html.gsub(/x/,no.to_s) + " " + word
  
  end
  
  def form_price_range_final_text(price_range_final,sub_category_id,products_list_id)

    price_range_final[sub_category_id].map {|i|

        if i[0] == products_list_id && i[3] == 0

          return "#{"%0.0f" % i[1] } - #{"%0.0f" % i[2]}","ranges_from"

        elsif i[0] == products_list_id && i[3] == 1

          return "#{"%0.0f" % i[1] }","starts_at"

        end

    }

  end

  def decide_price_range_starts_at(price_range_final,price_type)

    html = '<span class="gray-text text-n14">'
    
    text =  price_type.titleize + ": " 

      html = html + text + '<span style="font-weight:bold;color:#008080;font-size:14px;">Rs.'+price_range_final+'</span>'
      
      html += '<div class="comments-text padL5">
                          ( ... online shops)
                          </div>'
      html

  end


  def form_generic_to_specific_page_links(element_type,
                                          element_name,
                                          business_type,
                                          category_name,
                                          product_name,
                                          product_identifier,
                                          country_name,
                                          city_name = nil,
                                          area_names = nil,
                                          kind = "specific")
                                          
    if area_names == 0
    
      area_names = nil
    
    end                                          

    if  business_type == "online"

      html = create_online_specific_link(element_type,element_name,country_name,category_name,product_name,product_identifier)

    elsif business_type == "local"

      html = create_local_specific_link(element_type,element_name,country_name,city_name,area_names,category_name,product_name,product_identifier,kind)

    end

    html.html_safe

  end

  def create_online_specific_link(element_type,element_name,country_name,category_name,product_name,product_identifier)

    tail = form_element_tail(element_type,element_name,product_name)

    "<a href=/online-price-comparison/"+category_name+"/"+product_name+"/"+country_name+">"+ tail

  end

  def create_local_specific_link(element_type,element_name,country_name,city_name,area_names,category_name,product_name,product_identifier,kind = "specific")
  
    if kind == "specific"
    
      route = "price-comparison"
    
    elsif kind == "map"

      route = "location-in-maps"    
    
    end

    if element_type == "image"

        tail = form_element_tail(element_type,element_name,url_to_s(product_name))

    else

        tail = form_element_tail(element_type,url_to_s(element_name),url_to_s(product_name))

    end
    head = "<a href=/"+route+"/"+category_name+"/"+product_name+"/"+country_name+"/"+city_name.to_s

    if area_names.nil?

      head + ">" + tail

    else
    
      if (/^[\d-]*\d[\d-]*$/.match(area_names).nil?)
      
        head + "/"+area_names.to_s.titlecase.gsub(/ /,"-").downcase+">" + tail
        
      else
      
        head + "/"+area_names.to_s+">" + tail
        
      end  

    end

  end

  def form_element_tail(type,name,product)

    if type == "link"

       name.downcase.titleize+"</a>"

    elsif type == "image"

       "<img src='"+name+"' "+"alt='"+product+"'/></a>"

    end

  end

  def form_image_title_compare_elements(element_type,element,
                                        product_name,sub_category_flag,
                                        price_range_final,search_case,html_hash={})

        if element_type == "image"

          html = link_to image_tag(element),html_options,html_hash

        elsif element_type == "link"

           html = '<a href=/price/chennai/mobiles/'+product_name.gsub(/ /,"-")+'>'+product_name+' </a>'

        end

    html.html_safe

  end

  def form_image_title_misc_elements(element_type,element,
                                        specific_product_id,sub_category_flag,
                                        price_range_final,search_case,
                                        view_name,html_hash={},anchor_name = "")

     html_options = {}

     html_options = {:controller => 'specific',:action => 'specific_search', :specific_product_id => specific_product_id, :sub_category_id => sub_category_flag, :price_range => price_range_final,:search_case =>search_case, :view_name => view_name,:anchor => anchor_name}

        if element_type == "image"

          html = link_to image_tag(element),html_options,html_hash

        elsif element_type == "link"

          html = link_to element,html_options,html_hash

        end

    html

  end


  def set_generic_page_features(feature,feature_name)
  
     if feature.nil?
       
       html = '<b>'+feature_name.titleize+' : </b>'+"N.A."
     
     elsif !(feature.chomp.downcase.gsub(".","").gsub('$',",")== "na")

       html = '<b>'+feature_name.titleize+' : </b>'+truncate(feature.titlecase,:length => 25)

     else

       html = '<b>'+feature_name.titleize+' : </b>'+ ' N.A.'

     end

     html

  end

  def set_generic_page_generic_os(features)

     arr_generic_os = features[4].split("$")

     arr_generic_os_0 = arr_generic_os[0].chomp.downcase.gsub(".","")

     arr_generic_os_1 = arr_generic_os[0].chomp.downcase.gsub(".","")

         if arr_generic_os.count > 1

               if arr_generic_os_0 == "na" && arr_generic_os_1 == "na"

                 html = '<b>OS : </b> N.A.'

               elsif arr_generic_os_0 != "na" && arr_generic_os_1 == "na"

                 html= '<b>OS : </b>' + arr_generic_os[0].titlecase

               elsif arr_generic_os_0 == "na" && arr_generic_os_1 != "na"

                 html = '<b>OS : </b> N.A.'

               elsif arr_generic_os_0 != "na" && arr_generic_os_1 != "na"

                 html = '<b>OS : </b>' + arr_generic_os[0].titlecase

               end

        else

              html = '<b>OS : </b> N.A.'

        end

        html

  end

  def decide_search_form

    if @search_case == "products"

      html = render ('shared/form')

  elsif @search_case == "price"

      html = render ('price_search/form')

    end

    html

  end
  
  def set_counts_sub_category_flag# Used in generic page html   
  
    @category_counts = self.get_counts("array")
  
    @final_counts = self.get_counts("hash")
    
    @sub_category_flag ||= @final_counts.max_by{|k,v| v}[0]
  
  end

  def get_counts(type)
  
    final_counts = Hash.new
  
    @sub_categories = Subcategories.all
    
    total_count = 0
    
    category_count = 0
    
    @sub_categories.each do |i|
    
        category = split_x(i.sub_category_name,"_",0)
        
        category_size = eval("@"+category+"_all_count").to_i
        
        total_count = total_count + category_size
        
        if category_size != 0
        
          final_counts[i.sub_category_id] = category_size
        
          category_count = category_count + 1
        
        end
    
    end
    
     if type == "array"
     
      return [total_count,category_count]
       
     elsif type == "hash"
      
      return final_counts
     
     end

  end

  def get_current_counts(sub_category_id)
  
    @sub_category_name = Subcategories.find_by_sub_category_id(sub_category_id).sub_category_name
    
    category = split_x(@sub_category_name,"_",0)
    
    [eval("@"+category+"_all_count").to_i,category]
    
  end


  def set_product_avl(product_id,model,id,flag)
   
   model.where(id+" = ? ",product_id).select(flag).first.send(flag)

  end

end

