require "fileutils"
namespace :part1 do
#========================================================================
# -------------------SETUP FOR PART 1 -----------------------------------
# 1. There should be a folder destination
# 2. That folder can have many folders which has dat files names same as table names that dat is intended to
# To run rake part1:check do this, (here "/home/think/data/Part_1/" that the folder destination)
# rake part1:check MANY_PATH="/home/think/data/Part_1/2013may31Memory_Cards,/home/think/data/Part_1/2013may31Mouses,/home/think/data/Part_1/2013may31Pendrives,/home/think/data/Part_1/2013may31Printers,/home/think/data/Part_1/2013may31Routers,/home/think/data/Part_1/2013may31Speakers,/home/think/data/Part_1/2013may31Tablets,/home/think/data/Part_1/2013may31Desktops,/home/think/data/Part_1/2013may31External_HDDs,/home/think/data/Part_1/2013may31Headphones,/home/think/data/Part_1/2013may31Headsets,/home/think/data/Part_1/2013may31Keyboards,/home/think/data/Part_1/2013may31Laptops"

# To run rake part1:load do this, (here "/home/think/data/Part_1/" that the folder destination)
# rake part1:load MANY_PATH="/home/think/data/Part_1"

#========================================================================

#====  Variables Expansion ====
# files_path : Absolute path in which all the part1 files are located
# files : Array of files whose names are equal to the table names
#==============================
#====  Methods Glimpse ====

# set : This will take the env variable/anything as input check if its nil 
#       else set an instance variable with the same name and value

# aborts : This is the same abort in ruby with a little decoration

# say : outputs a msg on the console with decoration

#==============================
#==== Check part1 =========
  desc "Check the part1 files for error lines"
  task :check => :environment  do |t,args|
  
      ["many_path"].each do |i|
           # calling set to create instance variables of same name with passed ENV values
           set(i)
      end
      @s = 0
      @e = 0
      @many_path.split(",").each do |many|
          # assigning to files_path because its used inside
          @files_path = many

          Dir.glob(@files_path + "/**/*").select {|f| File.file? f}.each do |file_name|
          p file_name
            File.open(file_name,'r') do |infile|
              
                    while (line = infile.gets)
                    
                       @f = File.basename(file_name)
                       @d = File.dirname(@files_path)+"/log/"
                       if !Dir.exists?(@d)
                         FileUtils.mkdir(@d)
                       end
                       @log_path = @d + @f + "_err"
                    
                        line.encode!('UTF-8', 'UTF-8', :invalid => :replace)
                        @arr = line.split("|")
                    
                        @p1 = @arr[1]
                        @p1c = @arr[6]
                        @cat_name = @arr[4]
                        @cat = Subcategories.where(:sub_category_name => @cat_name).first
                        if !@cat.blank?
                        
                            @p2 = @cat_name.camelize.constantize.where(@cat.name.to_sym => @p1,@cat.id1.to_sym => @p1c).first
                            
                            if !@p2.nil?                
                                p "Success!"
                                @s += 1
                            else
                              @e += 1
                              p "===== START ==================="
                              p "Part - 1 : ####### #{@p1} ===== "
                              p "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxp2 was nil, examine why?"
                              p "===== END ==================="
                              
                              File.open(@log_path, 'a+') {|f| f.write(line) }
                              
                            end
                        else
                            @e += 1
                            p "===== START ==================="
                            p "Your sub_category_name is wrong.. It was #{@cat_name}, check it"
                            p "===== END ==================="
                            p 
                            File.open(@log_path, 'a+') {|f| f.write(line) }
                       end

                    end
            end
        end

        p "Number of success : #{@s}"
        p "Number of error : #{@e}"
    
    end

   end
#==== Load part1 =========
  desc "load part1 tables given a path full of part1 files with the same name as the table name"
  task :load => :environment  do |t,args|
  
      ["many_path"].each do |i|
           # calling set to create instance variables of same name with passed ENV values
           set(i)
      end
      @files = Dir.glob(@many_path + "/**/*").select {|f| File.file? f}
      
      @files.each do |i|
        
        tab = File.basename(i).downcase
        say ("Loading #{tab} from the path #{i}...")
        
        sql = "LOAD DATA LOCAL INFILE '#{i}' INTO TABLE #{tab} FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' set created_at=CURRENT_TIMESTAMP;"

         ActiveRecord::Base.connection.execute(sql)
         
        say("Loaded!")
        
      end
      say("Please check priority_errors table for more!")
      say("SELECT COUNT(*) FROM priority_errors;")
      say("SELECT * FROM priority_errors LIMIT 50 OFFSET;")
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
  
  #Connection adapter to the db, returns connection object
  def db
             
    ActiveRecord::Base.establish_connection(:adapter  => "mysql2",
                                            :database => "prod1",
                                            :user => "root",
                                            :password=>"Sector@123",
                                            :local_infile => true).connection()
  
  end
  
end

