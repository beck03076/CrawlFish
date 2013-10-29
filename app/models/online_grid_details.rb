class OnlineGridDetails < ActiveRecord::Base

  #has_many :bookslinks , :class_name => "LinkBooksListsVendors", :foreign_key => "unique_id"
  #has_many :grids, :through => :bookslinks , :class_name => "BooksLists", :foreign_key => "books_list_id"
  has_many :vendorlinks, :class_name => "LinkProductsListsVendors" , :foreign_key => "unique_id"
  has_many :vendor_logo, :through => :vendorlinks, :class_name => "VendorsList", :foreign_key => "vendor_id",:select => "vendor_logo"

  def self.get_grid(product_id,
                      sub_category_id,
                      e_a_id = 0,
                      order = "AFFILIATE DESC")    
      
     condition = "l.products_list_id = #{product_id} AND
                  l.sub_category_id = #{sub_category_id}"
    
        if !(e_a_id == 0)
        
          a_ids = e_a_id.join(",")
        
          condition += " AND l.availability_id NOT IN (#{a_ids})"
         
        end
        
     join = "INNER JOIN link_products_lists_vendors l ON 
                   l.unique_id = online_grid_details.unique_id 
                  INNER JOIN vendors_lists v ON 
                   v.vendor_id = l.vendor_id"
     
     select = "online_grid_details.*,v.*,online_grid_details.created_at as c_at ,online_grid_details.updated_at as u_at,count(*) as vars"
    
     joins(join).where(condition).select(select).group("v.vendor_name").order(order)

  end
end

