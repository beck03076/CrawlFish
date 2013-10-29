module UpdatePrice

  def scrapee(page,scrap,text)
  
   text = text.nil? ? 0 : text.to_i
  
   if !(scrap.nil?)
     els = 0
        
      if scrap.kind_of?(Array)
      
        if !(scrap[0].kind_of?(Array))
          scrap = scrap.split
        end

        scrap.each do |scr|
        
               method = scr[0]
               args = scr[1]
                
               flag = scr[2].nil? ? 0 : scr[2]
               
               @out = page.send(method,args)
           
               if flag != 0
                 if !(@out.blank?)
                   @out = page.send(method,args).send(flag)
                 end
               end
               
               if scr[3].kind_of?(Array)
                 alt_text = page.send(scr[3][0],scr[3][1]).text.strip.squish
               else
                 alt_text = scr[3]
               end

               if !(@out.blank?)      
                 @out = text == 1 ? @out.text.strip.squish : alt_text
                 break
               else
                 @out = els
               end

        end
           
      else 
          @out = scrap
      end
   @out
   end
  end

  def update(p,url,agent,dest)

      agent = Mechanize.new
      @init = agent.get(url)
      
      @kb = (@init.body.bytesize) / 1024.0
      puts "Visited(#{Time.now}) : #{url}"
      
      @price = 0
      @avail = 0
      @soffer = 0
      @stime = 0
      @scost = 0
      @page = nil
      default = {:product_price => 0,
                        :product_availability => 0,
                        :product_shipping_time => 0,
                        :product_shipping_cost => 0,
                        :product_special_offers => 0,
                        :kb => 0.0}

      if !(p[:sub].nil?)
         ps = p[:sub]
         
         if !(p[:sub][0].kind_of?(Array))
           ps = ps.split
         end
         
         ps.each do |p|
           res = @init.send(p[0],p[1])
         
           if !(res.blank?)
             @page = res
             break
           end

         end
        if blank(@page,url)
          return default
        end
      else
        @page = @init
      end
      
      if dest.include? ("product_availability")
      
        if !(p[:product_availability_text].nil?)
            temp = p[:product_availability_text]
            t = temp[0]
            sub = temp[1]
        else
            t = 0
        end
        
        @avail = self.scrapee(@page,p[:product_availability],t)
        
        if !(sub.nil?)
            sub.split(",").each do |s|
              s = s.split("|")
              @avail.sub! s[0],s[1]              
            end
        end
        
      end

      if dest.include? ("product_special_offers")
        if !(p[:product_special_offers_text].nil?)
          t = p[:product_special_offers_text]
        end
      
        @soffer = self.scrapee(@page,p[:product_special_offers],t)
      end
      
      if dest.include? ("product_shipping_time")
        @stime = self.scrapee(@page,p[:product_shipping_time],1)
      end

      if p[:product_shipping_cost_scrap] == 1
          @scost = self.scrapee(@page,p[:product_shipping_cost],1)
      end
      
      if dest.include? ("product_price")

            # Selecting those keys that is a number and sorting
            keys = p.keys.select{|i|  /[0-9]/ =~ i.to_s }.sort

            keys.each do |i|

                if !(p[i][0].kind_of?(Array))    
                  items = p[i].split
                else  
                  items = p[i]
                end

                items.each do |j|
                              
                  if j[1].blank?
                    res = @page.send(j[0])
                  else
                    res = @page.send(j[0],j[1])
                  end
                    if !(res.blank?)
                       @page = res
                       break
                    end
                
                end
                
            end

            @price = @page.inner_text.gsub(/,/,"").scan(/\d+/)[0]
        
        end
        
        if dest.include?("product_shipping_cost")

            if p[:product_shipping_cost_scrap] != 1
              sc = p[:product_shipping_cost]
              if !(sc.nil?)
                @scost = scost(sc,@price)
              end
            end 
            
        end

        {:product_price => @price,
        :product_availability => @avail,
        :product_shipping_time => @stime,
        :product_shipping_cost => @scost,
        :product_special_offers => @soffer,
        :kb => @kb}
        
  end
  
  def scost(sc,p)
     
    if sc.kind_of?(Array)
      if p.to_i > sc[0]
        "Free Shipping"
      else
        sc[1]
      end
    else
      sc
    end
    
  end
    
  def blank(page,url)
    if page.blank?  
      puts "== \e[31m Page was blank, check your URL/PATTERN - #{url} \e[0m=="
      return true
    end
  end
  
end
