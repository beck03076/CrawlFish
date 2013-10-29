require "fileutils"
namespace :popular do
#====  Variables Expansion ====
# file_path : Absolute path in which the popular products dat file is stored
# rec : Each line read from the dat file
# avl : Is the record already available in populars table?
# id_name : It is mobiles_list_id for mobiles_lists table
# p_l_id : Part 2 products_list_id for products fetched using product_name
#==============================
#====  Methods Glimpse ====

# set : This will take the env variable/anything as input check if its nil 
#       else set an instance variable with the same name and value

# aborts : This is the same abort in ruby with a little decoration

# say : outputs a msg on the console with decoration

#==============================
#==== ADD LOCAL =========
  desc "update the populars table based on the input from popular.dat"
  task :update => :environment  do |t,args|
 
  ["file_path"].each do |i|
       # calling set to create instance variables of same name with passed ENV values
       set(i)
  end

      # opening the dat file and iterating every line in the "line" variable
      File.open(@file_path, "r") do |infile|
      
            while (line = infile.gets)
            
                  # creating array from the line assuming pipe("|") as delimiter
                  rec = line.split("|")
                  say("Processing #{rec[0]}..")
                  
                  # counting the number of records with the same name in populars
                  avl = Populars.where(:name => rec[0],
                                       :brand => rec[1], 
                                       :category=> rec[2]).size
                                       
                  # forming the id_name from category, example "mobiles_list_id" from "mobiles_lists"
                  id_name = rec[2].to_s.chop+"_id"
                  
                  # if count is 0, record is new, else is old.
                  if avl == 0
                  
                    # select the products_list_id from the part 2 in the relevent model based on the value from rec[2]
                    p_l_id = (rec[2].camelize.constantize.where(rec[3] + " like ?", "%#{rec[0]}%").select(id_name).map &id_name.to_sym)[0]
                    
                    #No products_list_id found meaning the popular product doesnt exist in CF part-2
                    if (p_l_id.blank?)
                    
                        say("\e[32m#{"PRIORITY_CHECK => "}\e[0m"+"\e[31m#{"The popular product " + rec[0] +" does not exist in part-2"}\e[0m")
                    else
                    
                        say("Selected Products_list_id : #{p_l_id} for Product : #{rec[0]}")
                        
                        # populating the populars table with the name, brand and p_l_id
                        Populars.create(:name => rec[0],
                                        :brand => rec[1], 
                                        :category=> rec[2],
                                        :p_l_id => p_l_id)
                        say("\e[32m#{"Record Insert => "}\e[0m" + "Record : #{rec[0]} is NEW so its inserted as a popular product")
                    
                    end
                                    
                  else
                  
                    # outputting record skip if present in populars already
                    say("\e[31m#{"Record Skip => "}\e[0m" + "Record : #{rec[0]} already found in populars!")
                  end
            end
      end
        
      say("PRIORITY_CHECK is the keyword to search in your log file. Loacte PRIORITY_CHECK and fix it ASAP")
  
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
  
end

