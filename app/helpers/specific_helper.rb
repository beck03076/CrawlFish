module SpecificHelper

  include RubyUtilities
  
  # i will have an array of elements to display
  def a_avl(i,url)
    
   if @type == "local"
     html = i[0] + "at Rs." + i[1]
   elsif @type == "online"
     html = form_generic_to_specific_page_links("link",
                                          i[0],
                                          @type,
                                          @category_name,
                                          @product_name,
                                          @product_identifier,
                                          @country,
                                          @city,
                                          @area,
                                          @vedor_name) + "in " + i[1]
   end
   
   html
   
  end
  
  def sms(name,cl,no,what,v)
     
    link_to name,{:controller => "specific",
                                  :action => "sms",
                                  :vendor_id => @id,
                                  :product_id => @product_id,
                                  :sub_category_id => @sub_category_id,
                                  :product_name => @product_name,
                                  :vendor_name => v,
                                  :sms => no,
                                  :what => what,
                                  :unique_id => @uid,
                                  :vendor_alias_name => @v_alias},
                                  {:remote => :true,
                                  :class=>cl}
  
  end
  
  def form_similar_price(range)
  
   p = range.split("-")
  
   p = p[1].nil? ? p[0] : p[1]
   
   name = @category_name.titleize
   
   text = "Do not click here!"
   
   type = (@type == "local") ? 1 : 0
   
   html = link_to text,{:controller=> "price_search",
                        :action => "start_search",
                        :search_case => "price",
                        :price_query => p,
                        :sub_category_id => @sub_category_id,
                        :type => type,
                        :city => @city,
                        :country => @country},:class => "gray-button"
   
   html.html_safe
  
  end  
  
  def price_color(c_at,u_at)
  
   html = "style = font-size:16px;font-weight:bold;color:"
  
    if !(u_at.nil?)
    
      out = self.color(u_at)
      
    elsif !(c_at.nil?)
     
      out = self.color(c_at)
      
    else
    
      out = ["#C42525;","1","updated time unknown"]
     
    end 
    
    html += out[0]
    
    [html,out[1],out[2]]
       
  end
  
  def color(i)
  
    temp = " updated "+ time_ago_in_words(i) + " ago"
   
    if i <= 3.days.ago
      
        ["#7D2252;","1",temp]
        
    else
      
        ["#307D7E;","0",temp]
        
    end
  
  end
  
  def form_rating(flag = 0)
    
   rating = @rate[@id]

    #checking if there are ratings
   if !(rating.nil?) 
    
      s = rating[0]
      
      #Doing a math to round off the ratings to the nearest multiple of 5 
      s = s*10
      s = s - (s % 5)
      
      cl = ('"rating-static ' + 'rating-' + s.to_i.to_s + '"').html_safe
    
      #This span class decides what star to display
      html = "<span class=#{cl}></span>"
    
      if(s!=0.0)
        html += "<div class='red-text text-n14'>#{rating[0]} stars</div><br/><div class='gray-text'> Based on </br> <span class='red-text text-b12'>#{rating[1]} </span>ratings</div> </br>"
      else
        html += "<div class='gray-text text-n12 '>No user ratings yet! <br/>Contribute and help!</div><br/>"
      end
               
   else
   
      html = "<div class='gray-text text-n12 '>No user ratings yet! Contribute and help!</div><br/>"

   end
   
  
   if flag == 0

      html += link_to "User Reviews", params.merge({:controller => 'specific',
                                                  :action => 'vendor_rating',
                                                  :vendor_id => @id,
                                                  :shop => @v_name}),
                                                  :remote => :true,:class => "gray-button"
   end

   html.html_safe
   
  end
  
  def form_opposite_type
  
    if @type == "online"
    
        type = "local"
        #hard coded "chennai", has to be changed in future   
        city = "chennai"
        
        text = "View retail shops"
        
     elsif @type == "local"
     
         type = "online" 
         
         text = "View online shops"
         
         city = nil
         
     end
    
      form_generic_to_specific_page_links("link",
                                          text,
                                          type,
                                          @category_name,
                                          @product_name,
                                          @product_identifier,
                                          @country,
                                          city)
  
  end
  
  def form_data(arr,id)
  
    html = "<div id="+id+" >"
    
    arr.each do |i|
    
      html += "<div id=#{i} data-#{i}=#{eval("@"+i).to_s.gsub(/,/,"-")} > </div>"
            
    end
    
    html += "</div>"
    
    html.html_safe
      
  end
  
  def form_hub_links(kind = "specific")
  
    @say = "Not <b>filtered</b> by any location. Showing <b>important</b> areas in #{@city.titleize}." 
    
    html = "<div class='hub-nearby-details'>
    <div class='header-tab darkgray-text text-b14'>
        Hub Areas
        <span class='darkgray-text text-b12'> 
            (#{@city.titleize})
        </span>  
    </div>"    
    @hub.each do |i|
      
      html += "<div class='padL10 padT5 padTB5 border-graydot-b'>"
      
      html +=  form_generic_to_specific_page_links("link",
                                          i[0].titleize+"(#{i[1]})",
                                          "local",
                                          @category_name,
                                          @product_name,
                                          @product_identifier,
                                          @country,
                                          @city,
                                          i[0],
                                          kind)   
                                          
      html += "<br/>"                                     
                                          
      html += "</div>"
                                           
    end
    
    html += "</div>"
    
    html.html_safe
  
  end
  
  def set_area_messages
  
    area = @areas_now.empty? ? "requested area" : @areas_now.join(", ").titleize
       
    @say =  "<p> No shops found in <b>#{ area }</b>. Displaying shops in <b>#{@city.titleize } </b>. </p>"
  
  end
  
  def form_nearby_links(kind = "specific")
    
    @say = "<p>Filtered shops by "
    c_area = ""
    
    @areas_now.each do |now|
    
     c_area +=  form_generic_to_specific_page_links("link",
                                          now.titleize+" ",
                                          "local",
                                          @category_name,
                                          @product_name,
                                          @product_identifier,
                                          @country,
                                          @city,
                                          now,
                                          kind)
                                          
     end
     
     @say = "<div class='lightblack-text text-n11'>Filtered shops by <span class='red-link-b'>" + c_area + "</span>
     <div class='gray-text text-n10'>Shops from other areas are listed? (No, those are head office locations!)</div>
     </div>"
  
     html = "<div class='hub-nearby-details'>
        <div class='header-tab darkgray-text text-b14'>
            Areas nearby #{c_area}
        </div>"
    
    @kms.keys.each do |i|
      
        if !(@kms[i].empty?)
               
                 html +=  "<div class='subheader-tab'>" + "Within "+ i.to_s + "KMs</div>"
                 
        end
      
      @kms[i].each do |j|
          
          if !(j.empty?)
          
            if !(@areas_now.include?(j[0]))
            
                area = j[0]
                
                no = j[1].to_s
            
                html += "<div class='padL10 padT5 padB10 border-graydot-b'>" + form_generic_to_specific_page_links("link",
                                          area+"("+no+")",
                                          "local",
                                          @category_name,
                                          @product_name,
                                          @product_identifier,
                                          @country,
                                          @current_city.city_name,
                                          area,
                                          kind)
                                          
                html += "</div>"                                          
                
            end               
          end
        end    
    end
    
    html += '</div>'
    
    html.html_safe
    
  end
  
  def form_grid_div(i,spon = 0)
  
   if i % 2 == 0 
   
     ration = "odd"

   else 
   
     ration = "even"
     
   end
   
   if spon == 0
   
     html = '<div class="cf-local-shop-grid-table-'+ ration + '">'
   
   elsif spon == 1
   
     html = 'div class="cf-local-shop-grid-table-'+ ration +'-sponsored">
          <div class="cf-sponsored-listing-logo">CRAWLFISH BEST DEAL</div>
          <div style="clear:both"></div>'   
   
   end
   
   html.html_safe

  end
  
  def show_message
  
    if @type == "local" 
    
      self.help_message(@local_grids_count,' offline',@area_to_city)
      
    elsif @type == "online" 
    
      self.help_message(@online_grids_count,' online')
      
    end      

  end
  
  def help_message(count,text,cond = 0)
  
    a = String.new
        
        a += plurals(count,
                    "shop",
                    "<font color=#C42525><b>x</b></font>")
                          
        a +=  text 
        
    if cond == 1
    
      a += '<br/><br/>No shops found in '+ @area_names.titleize + '. Listing shops in '+ @current_city.city_name.titleize 
    
    end
            
    a.html_safe
  
  end

  def form_hidden_field_tags_specific_page(type)

    html = hidden_field_tag 'country', @country

    if type == "local"

      html = html + (hidden_field_tag 'city', @current_city.city_name)

      html = html + (hidden_field_tag 'area_names', @area_names)

    end

    html = html + (hidden_field_tag 'category_name',@category_name)

    html = html + (hidden_field_tag 'type',@type)

    html = html + (hidden_field_tag 'product_name',@product_name)

    html

  end
  
  def form_map_link(element_name,
                                  country_name,
                                  category_name,
                                  product_name,
                                  product_identifier,
                                  city_name,
                                  area_name,
                                  vendor_name = 0)
   
   start = "<a target=_blank href=/location-in-maps/"+category_name+"/"+s_to_url(product_name)+"/"+country_name+"/"+s_to_url(city_name.to_s)+"/"+s_to_url(area_name.to_s)
   
   stop = ' >'+element_name+"</a>"

   if !(vendor_name == 0)
   
     start += "/" + s_to_url(vendor_name)

   end

   (start + stop).html_safe

  end

  def form_specific_to_local_link (element_name,
                                  unique_id = nil,
                                  list = nil,
                                  country_name,
                                  category_name,
                                  product_name,
                                  product_identifier,
                                  city_name,
                                  area_name,
                                  vendor_name)
   
   start = "<a href=/price-comparison/"+category_name+"/"+s_to_url(product_name)+"/"+country_name+"/"+s_to_url(city_name.to_s)+"/"+s_to_url(area_name.to_s)+"/"+s_to_url(vendor_name)+"/"+list.to_s
   
   stop = ">"+element_name+"</a>"

   if !(unique_id.nil?)
   
     center = " data-unique_id = "+unique_id.to_s+" target='_blank'"
     
   else

     center = ""

   end

   (start + center + stop).html_safe

  end

  def show_element(element_name,element_value,element_name_div,element_value_div)

    if element_value != 0

      html = "<div class=" + element_name_div + ">" + element_name + " : "  "</div>"

      html = html + "<div class=" + element_value_div + ">" + element_value + "</div>"

    end

  end


  def form_specific_page_price

      html = '<div class="cf-specific-product-header-table-details-startsat"><span>'

          if @price_range.scan("-").empty?

            html = html + '<b> Starts at: </b>'

          else

            html = html + '<b> Price Range: </b>'

          end

      html = html + '<span class="rs-green">Rs.' + @price_range + '</span></span></div>'

      html

  end

  def form_out_of_stock_links(type,display,link_name,include)

    if @area_id.nil?

        html = link_to (link_name.capitalize+" Out Of Stock") , {:controller => "availablility", :product_id => @product_id , :sub_category_id => @sub_category_id , :type => type, :include => include,:search_case => @search_case}
        html = '<div id="'+type+'-'+link_name+'-out-of-stock" style="display:'+display+';">' + html + '</div>'
        html

    elsif !@area_id.nil?

         html = link_to (link_name.capitalize+" Out Of Stock") , {:controller => "availablility", :product_id => @product_id , :sub_category_id => @sub_category_id , :type => type, :include => include, :area_id => @area_id,:search_case => @search_case}
        html = '<div id="'+type+'-'+link_name+'-out-of-stock" style="display:'+display+';">' + html + '</div>'
        html

    end

  end

  def form_more_links(feature,id,name,count)

    html = String.new

           if count > 0

                 link = link_to("BROWSE", {:controller => 'filter',:action => 'recommendations',:feature => feature, :feature_id => id, :sub_category_id => @sub_category_id, :search_case => @search_case, :view_name => @view_name, :specific_product_id => @product_id, :query => name},:class=>'more-a')
         if @sub_category_id==1

         if count > 1
                   countText='books'
         else
            countText='book'
         end

         elsif @sub_category_id==2

         if count > 1
                   countText='mobiles'
         else
            countText='mobile'
         end

         end

         if feature=='genre'
                     html = '<div class="more-f1">Browse through&nbsp;<b>' + count.to_s + '</b>&nbsp;' +countText+ '&nbsp;in <span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> genre.<br/>'
             html1 = html
                      html2 = '</div> <br/>'

         elsif feature=='author'
             html = '<div class="more-f1"><span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> has penned&nbsp;'
                     html = html + '<b>' + count.to_s + '</b>'
                      html1 = html + '&nbsp;other&nbsp;' +countText+ ' too!<br/>'
                      html2 = '</div> <br/>'

         elsif feature=='publisher'
             html = '<div class="more-f1">Browse through&nbsp;<b>' + count.to_s + '</b>&nbsp;' +countText+ '&nbsp;from <span class="more">'
                     html = html + name.titlecase
                      html = html + '</span><br/>'
             html1 = html
                      html2 = '</div> <br/>'

        elsif feature=='mobile_brand'
             html = '<div class="more-f1"><span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> has&nbsp;'
                     html = html + '<b>' + count.to_s + '</b>'
                      html1 = html + '&nbsp;other exiciting&nbsp;' +countText+ ' too!<br/>'
                      html2 = '</div> <br/>'

        elsif feature=='mobile_type'
                     html = '<div class="more-f1">There are&nbsp;<b>' + count.to_s + '</b>&nbsp;' +countText+ '&nbsp;belonging to <span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> type.<br/>'
             html1 = html
                      html2 = '</div> <br/>'

        elsif feature=='mobile_design'
                     html = '<div class="more-f1">There are&nbsp;<b>' + count.to_s + '</b>&nbsp;' +countText+ '&nbsp;with <span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> as form factor.<br/>'
             html1 = html
                      html2 = '</div> <br/>'

        elsif feature=='mobile_os_version'
                     html = '<div class="more-f1">There are&nbsp;<b>' + count.to_s + '</b>&nbsp;' +countText+ '&nbsp;with <span class="more">'
                     html = html + name.titlecase
                      html = html + '</span> operating system.<br/>'
             html1 = html
                      html2 = '</div> <br/>'
        else
             html = '<div class="more-f1"><span class="more">'
                      html = html + name.titlecase
                      html = html + '</span> - '
                      html = html + count.to_s
                      html1 = html + ' products<br/><br/>'
             html2 = '</div> <br/>'
         end

                 html = html1 + link + html2

            else

                Rails.logger.debug "DEBUG-81057:..@more..  A more link --#{name}-- is not created because the count was 0" if Rails.logger.debug?

            end

     html

  end

  def get_mobile_reviews(product_name,product_brand,product_color)

    mobile_reviews = MobileReviews.where("mobile_name = ?",product_name).first

    if(!mobile_reviews.nil?)

        @mobile_reviews = mobile_reviews

        puts @mobile_reviews.review_landing_external_url

        end
  end

end

