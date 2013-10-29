module RubyUtilities
  
  include ModelsMethods
  
  def get_column_names(table)
  
    table.camelize.constantize.columns.map{|i| i.name}
  
  end
  
  def select_tables(pattern)
   
      ActiveRecord::Base.connection.tables.select{|n| n =~ pattern}
      
  end
  
  def split_x(value,pattern,x = 0)
  
    temp = value.split(pattern)
    
    temp.delete("lists")
    
    temp.join(pattern)
      
  end
  
  def model
  
    @sub_category_name.camelize.constantize
  
  end
  
  def modelize(i)
  
    i.camelize.constantize
  
  end
  # removed identifier from being set, since identifier/variants are shop specific
  def product_from_name_identifier(name,identifier)
  
     columns = RubyUtilities.m_columns(@sub_category_name)
     
     @product = self.model.where(:name_slug => name ).first
     
     @product_id = @product.send(columns[0])
  
  end
  
  def form_all_links
      
      #declaring variables
      @online_brands = h_arr      
      @local_brands = h_arr
      @price_steps = h_arr
      
      @brands = Hash.new{|hash, key| hash[key] = Array.new}
      Brands.all.map{|i| @brands[i.scid] << i.name }

      @sub_categories.each do |i|
          # shortening variable names
          sname = i.sub_category_name
          cname = i.category_name
          sid = i.sub_category_id
          b = @brands[sid]
          
         # id_filter1 = RubyUtilities.m_columns(sname)
         # brand = sname + '.' + id_filter1[1] 

          
         # LinkProductsListsVendors.get_part1_present_items(sid,
                   #                              sname,                                                 
                   #                              brand + ' as brand,vendors_lists.business_type as v',
                   #                              brand + ',vendors_lists.business_type').map{|i| h[i.v] << i.brand }
         

          @online_brands[cname] = b
                                                 
          @local_brands[cname] = b
          
          @price_steps[cname] = RubyUtilities.m_columns(sname)[9]

        end

  end
  
  #Returns an hash of arrays type
  def h_arr
    Hash.new{|hash, key| hash[key] = Array.new}
  end
  
  def url_to_s(a)  
    if a.nil?
      "0"
    else
      a.gsub(/-/," ").titleize
    end
  end
  
  def s_to_url(a)
    if a.nil?
      ""
    else
      a.to_s.downcase.gsub(/[^A-Za-z0-9&]/,"-")
    end
  end

  def get_key_of_max_value_count(hash)

    count_hash = Hash.new

    hash.keys.sort.each do |i|

          count_hash[i] = 0
          
          j = hash[i][:join].flatten
          
          t = hash[i][:title].flatten
          
          f = hash[i][:filter].flatten

          if !(j.empty?)

            count_hash[i] = count_hash[i] + j.size

          elsif !(t.empty?)

            count_hash[i] = count_hash[i] + t.size

          elsif !(f.empty?)

            count_hash[i] = count_hash[i] + f.size

          else

            count_hash[i] = count_hash[i] + 0

          end
    end

    count_hash.sort_by{|k,v| v}.reverse.map {|k,v| k}


           ##== This code can be reused, if you have an hash of arrays
           ##and if you want find out which key has the maximum number of values
           ##==start
           #hash.map { |k,v| if (v.nil?)
           #p k ,0 ;
           #elsif (v[0].nil?)
           #p k, 0;
           #else p k , v[0].length end }.sort_by {|k,v| v}.reverse.map {|k,v| k}
           ##==end

  end

  def validate_searchkey(searchkey)# this method is usead both in regular search and price search.

    if searchkey.empty?

      @message = 'No search key entered!'

      return false

    elsif searchkey.gsub(/[ ]/i, '').empty?

      @message = 'Entered only spaces!'

      return false

    elsif searchkey.gsub(/[^A-Za-z0-9]/,"").empty?

     @message = 'Entered only symbols!'

     return false

    end

    return true

  end


end


