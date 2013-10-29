class LocalGridDetails < ActiveRecord::Base


  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "unique_id"
  has_many :vendors, :through => :vendorlinks, :class_name => "VendorsList", :foreign_key => "vendor_id"

  def self.get_grid(product_id,
                    sub_category_id, 
                    e_a_id = 0,
                    a_id = 0, 
                    order = "AFFILIATE DESC")
     
     condition = "l.products_list_id = #{product_id} AND
                  l.sub_category_id = #{sub_category_id}"
    
    if (!(a_id == 0) && (e_a_id == 0))
    
      condition += " AND b.branch_id IN (#{a_id})"
      
    elsif ((a_id == 0) && !(e_a_id == 0))   
    
      a_ids = e_a_id.join(",")
    
      condition += " AND l.availability_id NOT IN (#{a_ids})" 
      
    elsif (!(a_id == 0) && !(e_a_id == 0))  
    
      a_ids = e_a_id.join(",")
    
      condition += " AND l.availability_id NOT IN (#{a_ids}) AND
                     b.branch_id IN (#{a_id})"
     
    end
    
     join = "INNER JOIN link_products_lists_vendors l ON 
                   l.unique_id = local_grid_details.unique_id 
                  INNER JOIN vendors_lists v ON 
                   v.vendor_id = l.vendor_id 
                  INNER JOIN link_vendors_lists_branches b ON 
                   b.vendor_id = l.vendor_id"
     
     select = "local_grid_details.*,v.*,local_grid_details.created_at as c_at ,local_grid_details.updated_at as u_at"
     
     joins(join).where(condition).select(select).group("v.vendor_name").order(order)

  end

end

