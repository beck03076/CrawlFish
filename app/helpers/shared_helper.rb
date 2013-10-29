module SharedHelper

  def set_head_tags(route)
  
      html = ""
      
      if route == "price"
          # shortify title
          t = @product_name.titleize 
          # prepare price range
          p = @price_range_final.values.flatten 
          p_show = p[3] == 0 ? p[1..2].join(" to ") : p[1] 
          
          o = @online_grids_count.to_s
          l = @local_grids_count.to_s
          c = o.nil? ? (l + " retail shops") : (o + " online shops")
          
          html += self.title(t + "Price in India - CrawlFish")
          
          html += self.meta_d(t + " is sold at Rs." + p_show.to_s + ". There are about #{c} selling #{t} as on #{Time.now.strftime("%a, %d %b %Y")}. Click through to know more about #{t}." )
          
          k = t + "," + t + " price,"
          ["india","chennai","mumbai","delhi","bangalore","hyderabad"].each do |x|
            k += "price in " + x + ","
          end      
          html += self.meta_k(k)
          
      elsif route == "shops"
          # shortify title
          c = @city.titleize 
          a = @area.nil? ? "" : @area.titleize 
          cat = @category_name.titleize
          out = [c,a].reject(&:blank?).join(",")
          
          html += self.title(cat + " shops in "+ out + " - CrawlFish")
          
          html += self.meta_d("List of all " + cat + " shops in " + out + ". Get best price of all #{cat}. Click here to view all #{cat} shops in " + out )
          
          k = cat + " shops, "
          ["india",c,a].each do |x|
            if !x.blank?
                k += cat + " shops in " + x + ","
            end
          end      
          html += self.meta_k(k)
      
      elsif route == "price-range"
          # shortify title
          po = @position
          pr = @price
          cat = @category_name.titleize
          out = [cat,"price",po,pr].join(" ")
          
          html += self.title(out + " in India - CrawlFish")
          
          html += self.meta_d("List of all " + cat + " with price " + po + " #{pr} in India. Also click to view best price of #{cat} in online and retail shops"   )
          
          k = out + " in india, "
          ["chennai","mumbai","delhi","bangalore","hyderabad"].each do |x|
            if !x.blank?
                k += out + " in " + x + ", "
            end
          end      
          html += self.meta_k(k)
          
      elsif route.nil?
          
          html += self.title("To know the best price of a product - CrawlFish")
          
          html += self.meta_d("To know the best price of a Mobile phone, a Laptop or any electronic item from not only online shops but also retail shops. Try once, you will love it.")
          
          html += self.meta_k("Mobile phones price in india,Laptops price in india,online shopping mobile phones,price comparison website in india,best price, best price of a product.")
          
      elsif route == "shops-list"
          
          html += self.title("List of retail shops in #{@area.titleize}, #{@city.titleize} - CrawlFish")
          
          html += self.meta_d("A complete list of all retail shops in #{@area.titleize}, #{@city.titleize}. Click through to view retail shops selling mobile phones, computer electronics and laptops in #{@city.titleize}.")
          
          html += self.meta_k("Mobile phone shops in #{@city.titleize}, Mobile phone shops in #{@area.titleize}, computer electronics shops in #{@city.titleize},computer electronics shops in #{@area.titleize}, laptops shops in #{@city.titleize}, laptops shops in #{@area.titleize}")
          
     elsif route == "price-list"
          # shortify title
          
          cat = @category_name.titleize
          bran = @brand_name.titleize
          cat_bran = bran + " " + cat
          
          html += self.title("Price list of #{cat_bran}" + " in India - CrawlFish")
          
          html += self.meta_d("Price list of all " + cat_bran + " in India. Click through to view the best price of #{cat_bran} from various online and retail shops"   )
          
          out = cat_bran + " price list"
          
          k = out + ", "
          ["india","chennai","mumbai","delhi","bangalore","hyderabad"].each do |x|
            if !x.blank?
                k += out + " in " + x + ", "
            end
          end      
          html += self.meta_k(k)
          
      elsif route == "specific"
      
          p_name = @product_name.titleize
          
          html += self.title("Price list with variants of #{p_name}" + " in India - CrawlFish")
          
          html += self.meta_d("Price list with variants and other models of " + p_name + " in India. Click through to view the best price of #{p_name} from various online and retail shops"   )
          
          out = p_name + " price list with variants and other models"
          
          k = out + ", "
          ["india","chennai","mumbai","delhi","bangalore","hyderabad"].each do |x|
            if !x.blank?
                k += out + " in " + x + ", "
            end
          end      
          html += self.meta_k(k)

      end
     
      
      html
  
  end
  
  def title(i)
    "<title>#{i}</title>\n"
  end
  
  def meta_k(i)
    "<meta name='keywords' content='#{i}'>\n"
  end
  
  def meta_d(i)
    "<meta name='description' content='#{i}'>\n"
  end

  def links(arr,disp,nf = nil,cl = nil)  
    href = arr.join("/")
    html = link_to(disp,href,{:rel => nf,:class => cl})
    html
  end

  def form_v(shops,admin)
  
  html = '<div class="vendors-list">'
  
      shops.each do |i| 
      
      ho = admin[i.vendor_id].blank? ? "N.A" : admin[i.vendor_id]
      
      v = form_links(truncate(i.vendor_alias_name,:length => 16),
                                        "shops-list",
                                        nil,
                                        @country,
                                        @city,
                                        ho,
                                        i.vendor_alias_name)
                                        
      html += '<div class="outer-box">
               <div class="vendor-box">
                <div class="overlay">
                  <div class="header-label">' +  v + '</div>
                  <div style="padding-bottom:5px">
                    <span class="sub-header-v">
                    <b>Timing:</b>
                    </span><br/>
                    <span class="sub-header-content">' + i.working_time + '</span>
                  </div>
              <div class="display-none">
                  <div style="padding-bottom:5px">
                    <span class="sub-header-v">
                    <b>Established:</b> 
                    </span><br/>
                    <span class="sub-header-content">' + i.established_year + '</span>
                  </div>
                  <div style="padding-bottom:5px">
                      <span class="sub-header-v">
                      <b>Head Office: </b> 
                      </span> <br/> 
                      <span class="sub-header-content">' + ho + '</span>
                  </div>
               </div>
            </div>
          <span id="vendor-desc" class="darkgray-text">' + truncate(i.vendor_description, :length => 130) + '</span>
        </div>
        </div>'
      end 
      
      html += '</div> 
      <div style="clear:both">&nbsp;</div>'
      
      html.html_safe
      
  end

  def tabs(url=nil,id)
   
      set = url.nil? ? "local" : url
      
      html =''
      
      if set == "local"
        html += '<li id="' + id + '" class="fr active-tab" data-type="local">Retail shops</li>'
        html += '<li id="' + id + '"class="fr" data-type="online">Online shops</li>'
      elsif set == "online"
        html += '<li id="' + id + '"class="fr" data-type="local">Retail shops</li>'
        html += '<li id="' + id + '"class="fr active-tab" data-type="online">Online shops</li>'
      end
      
      html.html_safe

  end
  
  def form_14(arr,div,nf = nil)   
   html = ""  
       arr.each do |chunk| 
        html += "<div class='#{div}'> <ul>"      
            chunk.each do |i|
              html += "<li>"
              html += form_links(truncate(i.titleize, :length => 15),
                      "shops-list",
                      nil,
                      @country,
                      @city,
                      i.downcase,nil,nil,nf)
              html += "</li>"
            end
         html += "</ul></div>"
       end 
    html.html_safe 
  end
  
  def form_14_url(arr,div,nf = nil)   
   html = ""  
       arr.each do |chunk| 
        html += "<div class='#{div}'> <ul>"      
            chunk.each do |i|
              html += "<li>"
              i = i.split("/")
              html += form_links(truncate(i[1].titleize, :length => 15),
                      "shops-list",
                      nil,
                      @country,
                      @city,
                      s_to_url(i[0].downcase),
                      s_to_url(i[1].downcase),nil,nf)
              html += "</li>"
            end
         html += "</ul></div>"
       end 
    html.html_safe 
  end
  
  def form_list_item(val,display,name,cl = 0,local = 0,shop = 0)
  
    if (local == 0)
    
      ("<li data-" + name + "="+ val+ " " + ">"+display+"</li>").html_safe
    
    else
    
      if val == cl
    
        cl = "selected"
      
      end
      
      if shop == 0
    
      ("<li data-" + name + "="+ val+ " " + "class=" + cl + ">" +
      form_specific_to_local_link(display,
                                  nil,
                                  val,
                                  @country,
                                  @category_name,
                                  @product_name,
                                  @identifier,
                                  @city,
                                  @area_names,
                                  @vendor.vendor_alias_name) +"</li>").html_safe
                                  
       elsif shop == 1
       
       ("<li data-" + name + "="+ val+ " " + "class=" + cl + ">" +
       form_links(display,
                  "shops-list",
                  nil,
                  @country,
                  @city,
                  @area,
                  @vendor_name,
                  val) +"</li>").html_safe
       
       
       
       end                           
    
    end
  
  end

  def form_brand_links(type,category_name,brand,country = nil,city = nil,area = nil,vendor_name = nil,what ="link")

    href = "/"+type+"/"+category_name+"/"+s_to_url(brand)+"/"+country.to_s+"/"+s_to_url(city)+"/"+s_to_url(area)+"/"+s_to_url(vendor_name)

    html = "<a href="+href.split("/").join("/")+">"+brand.titleize+"</a>"
    
    if what == "image"
       # this splits and joins to remove  things like ///
       href.split("/").join("/")
    else
       html.html_safe
    end

  end

  def form_city_area_vendor_links(category_name,country,city,area= nil,vendor_name = nil)

    if area.nil?

      href = "/"+"price-comparison/vendors"+"/"+category_name+"/"+country+"/"+s_to_url(city)

      html = "<a href="+href.split("/").join("/")+">"+city+"</a>"

    else

      href = "/"+"price-comparison"+"/"+category_name+"/"+country+"/"+s_to_url(city)+"/"+s_to_url(area)+"/"+s_to_url(vendor_name)

      if (vendor_name.nil?)

        html = "<a href="+href.split("/").join("/")+">"+area+"</a>"

      else

        html = "<a href="+href.split("/").join("/")+">"+vendor_name+"</a>"

      end

    end

    html.html_safe

  end

  def form_links(display,route,category_name = nil ,country = nil,city =nil ,area = nil, vendor_name = nil,list = nil, nf = nil)
    
    arr = (s_to_url(route)+","+s_to_url(category_name)+","+s_to_url(country)+","+s_to_url(city)+","+s_to_url(area)+","+s_to_url(vendor_name)+","+s_to_url(list)).split(",")
    
    str = ""
    
    arr.each do |i|
    
      if !(i.empty?)
      
         str = str + "/" + i
      
      end
     
    end
    
    if nf.nil?
        html = "<a href="+str+">"+display.to_s+"</a>"
    else
        html = "<a rel='"+nf+"' href="+str+">"+display.to_s+"</a>"
    end

    html.html_safe

  end

end

