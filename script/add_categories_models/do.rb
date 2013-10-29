require "fileutils"



category = ARGV[0].split
source = ARGV[1].split(",")

category.each do |i|

    source.each do |j|

        
        text = File.read(j)
        result = text.gsub(/<<pattern>>/,i).gsub(/<<PATTERN>>/,i.split("_").map{|i| i.capitalize}.join(""))
        
        outfile = j.gsub(/template/,i)
        
        File.open(outfile, 'w') { |f| f.write(result) }
        
        FileUtils.mv(outfile,"../../app/models/",:verbose => true)
        
  
    end
    
    
    

end


