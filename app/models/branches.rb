class Branches < ActiveRecord::Base

  has_many :vendorlinks , :class_name => "LinkVendorsListsBranches", :foreign_key => "branch_id"
  has_many :vendors, :through => :vendorlinks, :class_name => "VendorsList" , :foreign_key => "vendor_id"

  belongs_to :cities, :class_name => "Cities", :foreign_key => "city_id"


  def self.get_vendor_id_branch_name(vendor_name,product_id = 0 ,sub_category_id = 0)

    if (product_id == 0 && sub_category_id == 0)

      joins("INNER JOIN link_vendors_lists_branches ON branches.branch_id = link_vendors_lists_branches.branch_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_vendors_lists_branches.vendor_id AND vendors_lists.branch_name = branches.branch_name").where("f_stripstring(vendors_lists.vendor_alias_name) = ? ",vendor_name).select("vendors_lists.vendor_id,branches.branch_name")

    else

        joins("INNER JOIN link_vendors_lists_branches ON branches.branch_id = link_vendors_lists_branches.branch_id INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.vendor_id = link_vendors_lists_branches.vendor_id INNER JOIN vendors_lists ON vendors_lists.vendor_id = link_products_lists_vendors.vendor_id AND vendors_lists.vendor_id = link_vendors_lists_branches.vendor_id AND vendors_lists.branch_name = branches.branch_name").where("f_stripstring(vendors_lists.vendor_alias_name) = ? AND link_products_lists_vendors.products_list_id = ? AND link_products_lists_vendors.sub_category_id = ?",vendor_name.downcase.squeeze(" ").gsub(/ /,"").gsub(/,.-/,""),product_id,sub_category_id).select("vendors_lists.vendor_id,branches.branch_name")

    end

  end


  def self.get_current_branch(vendor_id)

    joins("INNER JOIN link_vendors_lists_branches
          ON branches.branch_id = link_vendors_lists_branches.branch_id
          INNER JOIN vendors_lists
          ON vendors_lists.vendor_id = link_vendors_lists_branches.vendor_id ").where("vendors_lists.vendor_id = ?",vendor_id).select("vendors_lists.vendor_id,branches.branch_name").map{|i| [i.branch_name,i.vendor_id]}[0]

  end

  def self.find_branch_name_list(vendor_id,city_id)

	 joins("INNER JOIN link_vendors_lists_branches
          ON branches.branch_id = link_vendors_lists_branches.branch_id").where("link_vendors_lists_branches.vendor_id IN (?) AND branches.city_id = ?",vendor_id,city_id).select("branches.branch_id,branches.city_id,branches.branch_name as branch_name").order("branches.branch_name ASC")

  end
  
  def self.nearby(id,km)
  
    if km.to_i == 0
     
     0
     
    else 
  
        table = "nearby_"+km.to_s+"kms_branches"
  
        joins(",cities c,branches d,"+table+" n").where("branches.branch_id =  n.branch_id AND d.branch_id = n.area_id AND c.city_id = n.city_id AND branches.branch_id IN (#{id})").select("d.branch_id as branch_id, d.branch_name as branch_name")
        
    end    
  
  end
  
  def self.areas_no(p_id,s_c_id,b_id = 0,hub = 0)
  
    if hub == 0 && b_id == 0
    
      cond = ""
      
    elsif !(hub == 0) && !(b_id == 0)
    
      cond = " AND v.branch_id IN (#{b_id}) AND branches.hub = 'y'"
      
    elsif !(hub == 0) && (b_id == 0)
    
      cond = " AND branches.hub = 'y'"  
      
    elsif (hub == 0) && !(b_id == 0)
    
      cond = " AND v.branch_id IN (#{b_id})"    
      
    end
  
    joins("INNER JOIN link_vendors_lists_branches v
          ON branches.branch_id = v.branch_id
          INNER JOIN link_products_lists_vendors l
          ON v.vendor_id = l.vendor_id ").where("l.products_list_id = #{p_id} AND l.sub_category_id = #{s_c_id}"+cond).select("branches.branch_name as b_name, COUNT(v.branch_id) as nos").group("v.branch_id")
  
  end

end

