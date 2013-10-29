require "fileutils"
namespace :jump do
#====  Variables Expansion ====
# s_date : Subscribed Date 
# m_type : Monetization Type
# cat_bran    : category and their brands hash
# cat : only the categories with comma separated
# site   : Website
# lat    : Latitude
# long   : Longitude
# @n : sql file name, its nothing but hours-minutes-seconds
# @h : sql file handler
# @d : directory name inside tasks folder
# @c_id : city_id
# @b_id : branch_id
# @v_id : vendor_id
#==============================
#====  Methods Glimpse ====

# set : This will take the env variable/anything as input check if its nil 
#       else set an instance variable with the same name and value

# db  : Connection adapter to the db, returns connection object

# ins_vend  : Insert the details got from the ENV arguments into the vendors_lists table 

# get_v_id  : Get the vendor_id from vendors_lists table based on the input got from ENV

# rationlize_params : This method takes the ENV params and operates on it with various special conditions and rationlizes it 

# sqlize_params :  This method will use the ENV rationlized _params and form @input such that it can be used on a INSERT sql statement

# vend_present? : check in vendors_lists whether another vendor with same name-type-city-area exists

# aborts : This is the same abort in ruby with a little decoration

# say : outputs a msg on the console with decoration

# prep_cols_names : Sets the value of @cols, @id_name, @bran_name

# jump : Calling the actual jump procedure in mysql that maps the vendors,products,brands and categories

# jump_sql : Calling this method will cd to /lib/tasks/date-sql/ and create a sql file that has a list of p_jump mysql stored procedures 

# get_b_id_admin  : Check existence and get the branch_id from branches table for passed admin_name and set @admin

# get_c_id  : Check existence and get the city_id from cities table for passed city

#==============================
#==== ADD LOCAL =========
  desc "Add a vendor to the CrawlFish database"
  task :vendor => :environment  do |t,args|
  
  @d = Date.today.to_s + "-sql"
  
  # Including this module to use its methods, a line in application.rb to load lib/modules is added. 
  include ModelsMethods
  
    ["type",
     "city",
     "area",
     "name",
     "cat_bran",
     "m_type",
     "s_date",
     "logo",
     "site",
     "email",
     "phone",
     "fax",
     "address",
     "lat",
     "long",
     "desc",
     "hrs",
     "misc",
     "trial",
     "del",
     "price",
     "avl",
     "del_cost",
     "del_time",
     "offers",
     "warr",
     "deli",
     "reason",
     "valid",
     "conf_by",
     "app_path",
     "alias",
     "admin_name",
     "premium",
     "authorised",
     "cards",
     "affiliate",
     "b_alias",
     "top"].each do |i|
       # calling set to create instance variables of same name with passed ENV values
       set(i)
     end
     # This take the command line params and evaluates it
     rationlize_params
     
     if vend_present?
       @dml = @del == "1" ? "DELETE" : "UPDATE"
       say("VendorName-Type-City-Area => #{[@name,@type,@city,@area].join("-")} combination already present!")
       # Get the vendor_id from vendors_lists table based on the input got from ENV
       get_v_id
     else
       @dml = "INSERT"
       #getting the city_id from cities table based on name from @city 
       get_c_id
       #getting the branch_id from branches table based on name from @admin_name 
       get_b_id_admin
       # This forms the @input to inserting data into vendors_lists
       sqlize_params
       # insert into vendors_lists the values from ENV       
       ins_vend
       # Get the vendor_id from vendors_lists table based on the input got from ENV
       get_v_id
     end
       # Iterating the given cat and bran and starting the actual jump
       @cat_bran.keys.each do |i|
         jump(i,@cat_bran[i])
       end
       
       cmd = 'mysql -u root -pSector@123 crawlfishdevdb < '+@app_path+'/lib/tasks/'+@d+'/'+@n
       
       say("KEY VALUES\ndml : #{@dml}\ndelete_flag : #{@del}\nvendor_id : #{@v_id}\ncategory_brand : #{@cat_bran}")
       puts "Copy and paste this command in the next line to add the products under categories and brands mentioned to #{@name}\n=======\n#{cmd}\n=======\n"
  end
  
  # Calling the actual jump procedure in mysql that maps the vendors,products,brands and categories
  def jump(cat,bran)  
    # Select names of various category matters, called from ModelsMethods module
    @cat_names = RubyUtilities.m_columns(cat)
    
    # Abort the task if CAT_BRAN is wrong or there is no configuration for any of the CAT in ModelsMethods module
    if @cat_names.nil?
      aborts("Names of one or more Category specified in CAT_BRAN is not configured in models_methods.rb module")
    end
    
    prep_cols_names
    
    b = bran.split(",").to_s.gsub(/\[/,"").gsub(/\]/,"")
    
        say("DOING #{@name} for BRAND => #{b} under CATEGORY => #{cat} ...")
    
        @sql = "call p_jump('#{@cols}',
                           '#{cat}',
                           '#{b}',
                           '#{@bran_name}',
                           '#{@v_id}',
                           '#{@del}',
                           '#{@type}',
                           '#{"v_id-"+@v_id.to_s+"-dml-"+@dml}',
                           '#{@price}',
                           '#{@avl}',
                           '#{@del_cost}',
                           '#{@del_time}',
                           '#{@offers}',
                           '#{@warr}',
                           '#{@deli}',
                           '#{@reason}',
                           '#{@valid}',
                           '#{@conf_by}');"
                           
        say("EXECUTE THE FOLLOWING SQL ON mysql PROMPT(Couldnt execute these Stored Procedures from Ruby ) => \n ========== \n #{@sql} \n ==========\n")        
        say("DONE")
        
        jump_sql
        
  end
  # Calling this method will cd to /lib/tasks/date-sql/ and create a sql file that has a list of p_jump mysql stored procedures 
  def jump_sql
  
    FileUtils.cd(@app_path+"/lib/tasks",:verbose => true)
    if File.directory? @d
       puts "Directory #{@d} exists"
     else
       FileUtils.mkdir @d, :mode => 0700,  :verbose => true
     end
     
     FileUtils.cd(@d,:verbose => true)
     @n = Time.now.strftime("%H%M%S")
     @h = File.open(@n,"a+")
     @h.write("\n#{@sql}\n")
     
  end

  # Sets the value of @cols, @id_name, @bran_name
  def prep_cols_names
  
    # assigning to i to increase readability
    a = @cat_names
    # concatenating the selected values from @cat_names to select from part-2 tables WITH comma
    # reordering based on the MYSQL cursor fetch using the array index
    @cols =""
    [a[0],a[4],a[2],a[1],a[3]].each do |i|
        j = i + "," 
        @cols = @cols + j
    end
    # removing the last appended COMMA
    @cols = @cols.chop
    
    @id_name = a[0]
    @bran_name = a[1]
  
  end
  
# This will take the env variable/anything as input check if its nil 
# else set an instance variable with the same name and value
  def set(i)
  
    env = ENV[i.upcase]
  
    if env.nil?
    
      aborts("\nCommand line arguments missing!,Clue : #{i}\n\n")
      
    else
    
       instance_variable_set("@" + i, env)
  
    end
      
  end
  
#Connection adapter to the db, returns connection object
  def db
             
    ActiveRecord::Base.establish_connection(:adapter  => "mysql2",
                                            :database => "prod1",
                                            :user => "root",
                                            :password=>"Sector@123").connection()
  
  end
  
# This method takes the ENV params and operates on it with various special conditions and rationlizes it  
  def rationlize_params
  
    if @s_date == 0
      # if no subscribed_date is supplied, using todays date in yyyy-mm-dd format
      @s_date = Time.now.strftime("%Y-%m-%d")
    end  
    
    @cat_bran = eval(@cat_bran)
    @cat = @cat_bran.keys.join(",")
      
  end
  
# This method will use the ENV rationlized _params and form @input such that it can be used on a INSERT sql statement
  def sqlize_params
  
    @bran = @cat_bran.values.join(",").split(",").uniq.join(",")
  
    @input = "'" + [@type,@city,@area,@name,@alias,@cat,@cat_bran,
                   @m_type,@s_date,@logo,@site,
                   @email,@phone,@fax,@address,@lat,
                   @long,@desc,@hrs,@misc,@trial,"now()",
                   @admin,@premium,@authorised,@cards,
                   @affiliate,@b_alias,@bran,@top].join("','") + "'"
  
  end
  
# check in vendors_lists whether another vendor with same name-type-city-area exists
  def vend_present?
    
     sql = "SELECT COUNT(*)
             FROM vendors_lists
             WHERE  business_type = '#{@type}' AND
                    city_name = '#{@city}' AND
                    branch_name = '#{@area}' AND
                    vendor_name = '#{@name}'"

     db.execute(sql).map{|i| i[0] == 0 ? nil : 1 }[0]
  
  end
  

# Insert the details got from the ENV arguments into the vendors_lists table and get the inserted vendor_id  
  def ins_vend
  
    sql = "INSERT INTO vendors_lists(business_type,
                                     city_name,
                                     branch_name,
                                     vendor_name,
                                     vendor_alias_name,
                                     vendor_sub_categories,
                                     cat_bran,
                                     monetization_type,
                                     subscribed_date,
                                     vendor_logo,
                                     vendor_website,
                                     vendor_email,
                                     vendor_phone,
                                     vendor_fax,
                                     vendor_address,
                                     latitude,
                                     longitude,
                                     vendor_description,
                                     working_time,
                                     miscellaneous,
                                     trial_flag,
                                     created_at,
                                     admin,
                                     premium,
                                     authorised,
                                     cards,
                                     affiliate,
                                     branch_alias_name,
                                     brands,
                                     top)
            VALUES(#{@input})"
 
    db.execute(sql)
    
    say("Inserted into vendors_lists - #{@name}")
  
  end
  
  def get_v_id
  
   sql = "SELECT vendor_id 
             FROM vendors_lists
             WHERE  business_type = '#{@type.to_s}' AND
                    city_name = '#{@city.to_s}' AND
                    branch_name = '#{@area}' AND
                    vendor_name = '#{@name}'"

    @v_id = db.execute(sql).map{|i| i}[0][0]
    
    say("Selected v_id - #{@v_id}")
    
  end
  # check whether the passed admin_name is already an area/branch covered at CF for this city. 
  def get_b_id_admin
  
   sql = "SELECT COUNT(*)
             FROM branches
             WHERE  branch_name = '#{@admin_name}' AND
             city_id = '#{@c_id}'"

   ans = db.execute(sql).map{|i| i[0] == 0 ? nil : 1 }[0]
   
   if ans  
       sql = "SELECT branch_id
                 FROM branches
                 WHERE  branch_name = '#{@admin_name}' AND
                 city_id = '#{@c_id}'"
        @admin = db.execute(sql).map{|i| i}[0][0]        
        say("Selected branch_id for admin - #{@admin}")
   else
     aborts("\nPassed admin_name does not exist in Branches table,Clue admin_name: #{@admin_name}\n\n")   
   end
    
  end
  # check whether the passed city is already a city covered at CF for this country.
  def get_c_id
    
    sql = "SELECT COUNT(*)
             FROM cities
             WHERE city_name = '#{@city.to_s}'"

    ans = db.execute(sql).map{|i| i[0] == 0 ? nil : 1 }[0]
   
   if ans  
       sql = "SELECT city_id
                 FROM cities
                 WHERE city_name = '#{@city.to_s}'"
        @c_id = db.execute(sql).map{|i| i}[0][0]        
        say("Selected city_id for city - #{@city}")
   else
     aborts("\nPassed city does not exist in cities table,Clue city: #{@city}\n\n")   
   end
    
  end
  
# This is the same abort in ruby with a little decoration
  def aborts(i)
   puts "\n===============\n"
   puts i
   puts "===============\n"
   abort
  end

# outputs a msg on the console with decoration
  def say(i)
   puts "\n===============\n"
   puts i
   puts "===============\n"
  end
#==============================
#==== UPDATE RETAIL SHOP CATALOG WITH NEW PART-2 PRODUCTS =========
  desc "Add a vendor to the CrawlFish database"
  task :update => :environment  do |t,args|
    # Including this module to use its methods, a line in application.rb to load lib/modules is added. 
  include ModelsMethods
  
  @d = Date.today.to_s + "-sql"
  
    @msg = []
    say("Started jump update .. ")
    ["app_path,/home/think/CrawlFish","cat,0","vend,0","price,0",
    "del,0","type,local","avl,In Stock","del_cost,Free Delivery",
    "del_time,24 business hours","offers,future","warr,Manufacturers",
    "deli,y","reason,Jump Update","valid,Forever","conf_by,unknown"].each do |i|
      x = i.split(",")
      set_or_init(x[0],x[1])
      @msg << x[0]
    end
    say("Consider knowing that you can pass these params & override.. #{@msg.join(",")}")

    if @cat != "0"
        @cat.split(",").each do |c|
          if !valid_cat?(c)
            aborts("Category - #{c} not present in Subcategories ..")
          end
        end
    else
        @cat = Subcategories.all.map{|i| i.sub_category_name }
    end
    
    if @vend != "0"
        @vend.split(",").each do |v|
          if !valid_vend?(v)
            aborts("Vendor - #{v} not present in VendorsList(business_type = local)..")
          end
        end
    else
      @vend = VendorsList.where(:business_type => "local").map{|i| [i.vendor_name,i.city_name,i.branch_name,i.cat_bran]}
    end
    
    say("#{@cat.size } categories going to be processed .. #{@cat}")
    say("#{@vend.size} vendors going to be processed ..")
    @h = {}
    @cat.map{|i| @h[i] = 0 }
    say("Numbers category-wise : #{@h}")
    
    puts "Do you want to go ahead and do this big fat task? (y/n)"

    answer = STDIN.gets.chomp.downcase
    
    if answer == 'y'
            @logger = []
            @cw = {}
            @cat.map{|i| @cw[i] = 0 }
            

            @vend.each do |v|
              
              @cat.each do |c|
            
                c_b = v[3]
                n = v[0]
                if !c_b.nil?
                    p "=== Evaluating #{c} for #{n} ==="
                    c_b = eval(c_b).keys
                    if c_b.include?(c)
                        @logger << v[0] + "," + c
                        jump_update(v,c)
                    end
                end
              end
            end
            
            cmd = 'mysql -u root -pSector@123 crawlfishdevdb < '+@app_path+'/lib/tasks/'+@d+'/'+@n
               
               say("KEY VALUES\ndml : #{@dml}\ndelete_flag : #{@del}\nvendor_id : #{@v_id}\ncategory_brand : #{@cat_bran}")
               
               say("Number of Loops : #{@logger.size}")
               @logger.uniq.map{|i| @cw[i.split(",")[1]] += 1}
               
               @logger.uniq.each do |i|
                 p "List of Loops: #{i}"
               end
               
               say("Numbers category-wise(numbers wont compensate if added, because a uniq has been done) : #{@cw}")
               
               puts "Copy and paste this command in the next line to add the products under categories and brands \n=======\n#{cmd}\n=======\n"
               
     elsif answer == 'n'
       aborts("Alright, have a nice day!")     
     end
     
     puts "COPY PASTE the ABOVE URL in another terminal and press y, after its complete! Do you want to populate the jumps table with the timestamp, so that ** YOU CONFIRM THAT THE JUMP UPDATE WAS SUCCESSFUL AND TIMESTAMP FROM PART_2 TABLES WILL BE STORED FOR EVERY CATEGORY ** Please say n if you are not sure about anything ? (y/n)"
     
     answer = STDIN.gets.chomp.downcase
    
     if answer == 'y'
       Subcategories.all.each do |s|
         cat = s.sub_category_name
         p "Starting for #{cat} .. "
         
         ans = cat.camelize.constantize.select('GREATEST(IFNULL(MAX(UPDATED_AT),0),IFNULL(MAX(CREATED_AT),0)) as t')
         t = ans.map{|i| i.t}[0]
         obj = Jumps.find_or_create_by_cat(:cat => cat)
         obj.update_attribute(:t,t)

             p "=========================="
             p "Processed #{cat} for time #{t} on jumps .."
             p "=========================="
        end
      elsif answer == 'n'
        aborts("Win like a man, lose like man! Your courage to say no is very much appreciated, now go, fix what you doubted of")     
      end
     


    
  
  end
  def jump_update(vend,cat)
  
    say ("Single Vendor, Single Category started for .. #{vend} & #{cat}")
   # Select names of various category matters, called from ModelsMethods module
    @cat_names = RubyUtilities.m_columns(cat)
    
    # Abort the task if CAT_BRAN is wrong or there is no configuration for any of the CAT in ModelsMethods module
    if @cat_names.nil?
      aborts("Names of one or more Category specified in CAT_BRAN is not configured in models_methods.rb module")
    end
    
    prep_cols_names
    
    vend1 = VendorsList.where(:vendor_name => vend[0], :city_name => vend[1], :branch_name => vend[2]).first
    @v_id = vend1.vendor_id
    cat_bran = vend1.cat_bran
    
    if !(cat_bran.nil?)
    
      cat_bran = eval(cat_bran)
      
      if (cat_bran[cat].nil?)
        say("CATEGORY => #{cat} not sold by #{vend}...")
      else
          b = cat_bran[cat].split(",").to_s.gsub(/\[/,"").gsub(/\]/,"")
          
          say("DOING .. BRAND => #{b} under CATEGORY => #{cat} ...")
          
          t = Jumps.find_by_cat(cat).t
        
          @sql = "call p_jump_update('#{@cols}',
                               '#{cat}',
                               '#{b}',
                               '#{@bran_name}',
                               '#{@v_id}',
                               '#{@del}',
                               '#{@type}',
                               '#{"v_id-"+@v_id.to_s+"-dml-update"}',
                               '#{@price}',
                               '#{@avl}',
                               '#{@del_cost}',
                               '#{@del_time}',
                               '#{@offers}',
                               '#{@warr}',
                               '#{@deli}',
                               '#{@reason}',
                               '#{@valid}',
                               '#{@conf_by}',
                               '#{t}');"
                               
            say("EXECUTE THE FOLLOWING SQL ON mysql PROMPT(Couldnt execute these Stored Procedures from Ruby ) => \n ========== \n #{@sql} \n ==========\n")        
            say("DONE")
            
            jump_sql
        
        end
      
    else 
      say("Category #{cat} is not sold by Vendor #{vend}.. So skipping jump update ..")
    end
    
  end
  
  def valid_cat?(c)
    Subcategories.all.map{|i| i.sub_category_name }.include?(c)
  end
  
  def valid_vend?(v)
    VendorsList.where(:business_type => "local").map{|i| [i.vendor_name,i.city_name,i.branch_name].join("-") }.include?(v.split(",").join("-"))
  end
  
  # This will take the env variable/anything as input check if its nil , if nil set the variable passed as val
# else set an instance variable with the same name and value
  def set_or_init(i,val)
  
    env = ENV[i.upcase]
  
    if env.nil?
    
      instance_variable_set("@" + i, val)
      
    else
    
       instance_variable_set("@" + i, env)
  
    end
      
  end
  
end

