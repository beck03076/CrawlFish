class MobilesLists < ActiveRecord::Base

   include ModelsMethods

   has_many :mobile_brand_links , :class_name => "LinkF1MobilesLists", :foreign_key => "mobiles_list_id"
   has_many :mobile_brands, :through => :mobile_brand_links, :class_name => "MobilesF1MobileBrand", :foreign_key => "mobile_brand_id"

   has_many :mobile_type_links , :class_name => "LinkF3MobilesLists", :foreign_key => "mobiles_list_id"
   has_many :mobile_types, :through => :mobile_type_links, :class_name => "MobilesF3MobileType", :foreign_key => "mobile_type_id"

   has_many :mobile_design_links , :class_name => "LinkF4MobilesLists", :foreign_key => "mobiles_list_id"
   has_many :mobile_designs, :through => :mobile_design_links, :class_name => "MobilesF4MobileDesign", :foreign_key => "mobile_design_id"

   has_many :mobile_os_version_links , :class_name => "LinkF5MobilesLists", :foreign_key => "mobiles_list_id"
   has_many :mobile_os_versions, :through => :mobile_os_version_links, :class_name => "MobilesF5OsVersion", :foreign_key => "mobile_os_version_id"

   has_many :vendorlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :vendors, :through => :vendorlinks , :class_name => "VendorsList", :foreign_key => "vendor_id"

   has_many :onlinegridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :online_grids, :through => :onlinegridlinks , :class_name => "OnlineGridDetails", :foreign_key => "unique_id"

   has_many :localgridlinks , :class_name => "LinkProductsListsVendors", :foreign_key => "products_list_id"
   has_many :local_grids, :through => :localgridlinks , :class_name => "LocalGridDetails", :foreign_key => "unique_id"
   #senthil - 2012mar02 add availability to books and vendors
   has_many :availabilitylinks , :class_name => "LinkProductsListsVendors", :foreign_key => "availability_id"
   has_many :availabilities, :through => :availabilitylinks , :class_name => "VendorsList", :foreign_key => "vendor_id"
   
   define_index do
    indexes mobile_name
   end
   
   def self.a(mobile_name)

     where("f_stripstring(mobile_name) = f_stripstring(?) AND mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobile_name).select("mobiles_list_id,mobile_color").order("mobiles_list_id").map{|i| [i.mobile_color.titlecase,i.mobiles_list_id]}

   end   

   def self.check_distinct_product_name_count(mobiles_list_id_array)

     where(:mobiles_list_id => mobiles_list_id_array).select("distinct(mobile_name)").size

   end

   def self.fetch_exact_match(product_id)

    where("mobiles_list_id= ?",product_id)

   end

   def self.fetch_exact_match_color(product_name,color = 0)

    where("mobile_name= ? and mobile_color = ?",product_name,color).first

   end

   def self.get_mobile_name(mobiles_list_id)

     where("mobiles_list_id= ?",mobiles_list_id).map &:mobile_name

   end

   def self.get_colors_mobiles_list_id_part1(mobile_name)

     where("f_stripstring(mobile_name) = f_stripstring(?) AND mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobile_name).select("mobiles_list_id,mobile_color").order("mobiles_list_id").map{|i| [i.mobile_color.titlecase,i.mobiles_list_id]}

   end

   def self.get_mobile_brand_ids(mobiles_list_id)

    find(mobiles_list_id).mobile_brands.map {|i| [i.mobile_brand_id,i.mobile_brand_name] }

   end

    def self.get_mobile_type_ids(mobiles_list_id)

    find(mobiles_list_id).mobile_types.map {|i| [i.mobile_type_id,i.mobile_type_name] }

   end

    def self.get_mobile_design_ids(mobiles_list_id)

    find(mobiles_list_id).mobile_designs.map {|i| [i.mobile_design_id,i.mobile_design_name] }

   end

    def self.get_mobile_os_version_ids(mobiles_list_id)

    find(mobiles_list_id).mobile_os_versions.map {|i| [i.mobile_os_version_id,i.mobile_os_version] }

   end

   def self.get_mobiles_count

	 joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id = mobiles_lists.mobiles_list_id").where("link_products_lists_vendors.sub_category_id = 2").find(:all,:select => "DISTINCT mobile_name").count

   end

  def self.get_mobile_names_avl_in_part1(search_key)
	
	 joins("INNER JOIN link_products_lists_vendors ON link_products_lists_vendors.products_list_id = mobiles_lists.mobiles_list_id").where("link_products_lists_vendors.sub_category_id = 2 AND mobiles_lists.mobile_availability_flag = 'y' AND mobiles_lists.mobile_name like ?",search_key).select("DISTINCT(mobiles_lists.mobile_name)").map{|i| [i.mobile_name.titlecase]}

   end

end

