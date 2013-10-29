class LinkProductsListsVendors < ActiveRecord::Base

  include ModelsMethods

  #belongs_to :books, :class_name => "BooksList", :foreign_key => ["products_list_id","sub_category_id"]
  #belongs_to :mobiles, :class_name => "MobilesList", :foreign_key => "products_list_id"

  belongs_to :vendors, :class_name => "VendorsList", :foreign_key => "vendor_id"
  belongs_to :vendor_logo, :class_name => "VendorsList", :foreign_key => "vendor_id"

  belongs_to :availabilities , :class_name => "books_v_f10_availabilities", :foreign_key => "availability_id"
  belongs_to :online_grids, :class_name => "OnlineGridDetails", :foreign_key => "unique_id"
  belongs_to :local_grids, :class_name => "LocalGridDetails", :foreign_key => "unique_id"

  belongs_to :grids, :class_name => "LocalGridDetails", :foreign_key => "unique_id"
  belongs_to :branches, :class_name => "LinkVendorsListsBranches", :foreign_key => "vendor_id"
  belongs_to :vendorlinks, :class_name => "LinkVendorsListsBranches", :foreign_key => "vendor_id"
  
   def self.price_step(sid,tab,type,pos,price,id,select)
   
    t_name = type +"_grid_details"
   
    head = "link_products_lists_vendors.sub_category_id = #{sid}"
    
    if pos == "between"     
      p = price.split("-")    
      cond = " AND i.price BETWEEN #{p[0]} AND #{p[1]}"    
    else    
      if pos == "above"
        x = ">"
      elsif pos == "below"
        x = "<"
      end      
      cond = " AND i.price #{x} #{price}"    
    end
    
    cond = head + cond
   
     joins("INNER JOIN #{t_name} i ON
            i.unique_id = link_products_lists_vendors.unique_id
            INNER JOIN #{tab}  ON
            link_products_lists_vendors.products_list_id = #{id}").where(cond).select(select).group("name_slug")
            
   end
   
   def self.get_part1_present_items(sub_category_id,
                                    sub_category_name,
                                    item,
                                    by = nil,
                                    area = 0, 
                                    brand = 0,
                                    type = 0)

     id_filter1 = m_columns(sub_category_name)

     id = id_filter1[0]

     filter1 = id_filter1[1]

     joins("INNER JOIN "+sub_category_name+" ON link_products_lists_vendors.products_list_id = "+sub_category_name+"."+id+" INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id").where("link_products_lists_vendors.sub_category_id = ?  AND vendors_lists.branch_name IN (?) AND "+sub_category_name+"."+filter1+" IN (?) AND vendors_lists.business_type = ?",sub_category_id,area,brand,type).select(item).group(by)

   end

   def self.get_products_list_id(sub_category_id)

    where("sub_category_id = ?",sub_category_id).select("distinct(products_list_id)").map &:products_list_id

  end

  def self.get_unique_id(products_list_id,sub_category_id,availability_ids = 0,vendor_id = 0)

    if availability_ids == 0 && vendor_id == 0

      where("products_list_id = ? AND sub_category_id = ?",products_list_id,sub_category_id).select("unique_id").map &:unique_id

    elsif !(vendor_id == 0)

      where("products_list_id = ? AND sub_category_id = ? AND vendor_id = ?",products_list_id,sub_category_id,vendor_id).select("unique_id").map &:unique_id

    else

      where("products_list_id = ? AND sub_category_id = ? AND availability_id NOT IN (?) ",products_list_id,sub_category_id,availability_ids).select("unique_id").map &:unique_id

    end

  end

  def self.get_products_list_id_from_unique_id(unique_id)

    where(:unique_id  => unique_id).select("products_list_id").first

  end

  def self.get_products_list_id_sub_category_id_from_unique_id(unique_id,sub_category_id = 0)

    if sub_category_id == 0

      where(:unique_id  => unique_id).select("DISTINCT(products_list_id) AS products_list_id,sub_category_id")

    else

      where(:unique_id  => unique_id,:sub_category_id => sub_category_id).select("DISTINCT(products_list_id) AS products_list_id,sub_category_id")

    end

  end

  def self.get_vendor_id_from_unique_id(product_id,sub_category_id=0)

    if sub_category_id == 0

        joins("INNER JOIN vendors_lists ON link_products_lists_vendors.vendor_id = vendors_lists.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND vendors_lists.business_type='local'",product_id).select("link_products_lists_vendors.vendor_id")

    else

        joins("INNER JOIN vendors_lists ON link_products_lists_vendors.vendor_id = vendors_lists.vendor_id").where("link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ? AND vendors_lists.business_type='local'",product_id,sub_category_id).select("link_products_lists_vendors.vendor_id")

    end
  end

end

