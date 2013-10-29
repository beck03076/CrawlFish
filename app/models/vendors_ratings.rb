class VendorsRatings < ActiveRecord::Base
  
  def self.reviews(v_id)
  
     joins("INNER JOIN customer_care_entries c ON
            c.id = vendors_ratings.customer_id").where("vendors_ratings.vendor_id = #{v_id}").select("c.customer_name as name,c.customer_phone_no as ph, c.customer_email as email,vendors_ratings.reviews as review,vendors_ratings.ratings as rating,vendors_ratings.created_at as c_at").order("vendors_ratings.created_at DESC")    
  
  end
  
  def self.ratings(v_ids,sort = "DESC")
  
    arr = []
    
    arr << v_ids
  
    i = arr.flatten.join(",") 
    
    v_ids = !(i.empty?) ? i : 0    
  
    joins("RIGHT OUTER JOIN vendors_lists v ON
            v.vendor_id = vendors_ratings.vendor_id").where("v.vendor_id IN (#{v_ids})").select("AVG(IFNULL(vendors_ratings.ratings,0)) as avg,count(v.vendor_id) as nos,v.vendor_id as vendor_id").group("v.vendor_id").order("avg "+sort)
  
  end  
  
end
