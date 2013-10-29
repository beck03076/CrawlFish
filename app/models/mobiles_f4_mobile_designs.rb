class MobilesF4MobileDesigns < ActiveRecord::Base

  has_many :mobile_design_links , :class_name => "LinkF4MobilesLists", :foreign_key => "mobile_design_id"
  has_many :mobiles, :through => :mobile_design_links, :class_name => "MobilesLists" , :foreign_key => "mobiles_list_id"

  def self.get_display_name(mobile_design_id)

    where("mobile_design_id IN (?)", mobile_design_id ).select("mobile_design_name").map {|v| v.mobile_design_name}

  end

  def self.get_mobiles_count_excluding_specific_product(mobile_design_id,mobiles_list_id)

    inner_query = MobilesF4MobileDesign.find(mobile_design_id).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobiles_list_id).select("COUNT(*) AS a,link_f4_mobiles_lists.mobile_design_id AS b").group("mobiles_lists.mobile_name")

    outer_query = MobilesF4MobileDesign.scoped

    outer_query = outer_query.from(Arel.sql("(#{inner_query.to_sql}) as results")).select("COUNT(*) AS mobile_design_count,b AS mobile_design_id")

       #find(mobile_design_id).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobiles_list_id).group("mobiles_lists.mobile_name").size.count

  end

  def self.get_products_list_id_from_feature_id(mobile_design_id)

    find(mobile_design_id).mobiles.map &:mobiles_list_id

  end

end

