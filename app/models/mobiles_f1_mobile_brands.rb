class MobilesF1MobileBrands < ActiveRecord::Base

  has_many :mobile_brand_links , :class_name => "LinkF1MobilesLists", :foreign_key => "mobile_brand_id"
  has_many :mobiles, :through => :mobile_brand_links, :class_name => "MobilesLists" , :foreign_key => "mobiles_list_id"


  def self.get_display_name(mobile_brand_id)

    where("mobile_brand_id IN (?)", mobile_brand_id ).select("mobile_brand_name").map {|v| v.mobile_brand_name}

  end

  def self.get_mobiles_count_excluding_specific_product(mobile_brand_id,mobiles_list_id)

    inner_query = MobilesF1MobileBrand.find(mobile_brand_id).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobiles_list_id).select("COUNT(*) AS a,link_f1_mobiles_lists.mobile_brand_id AS b").group("mobiles_lists.mobile_name")

    outer_query = MobilesF1MobileBrand.scoped

    outer_query = outer_query.from(Arel.sql("(#{inner_query.to_sql}) as results")).select("COUNT(*) AS mobile_brand_count,b AS mobile_brand_id")

    # find(12).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",2).group("mobiles_lists.mobile_name").size.count

  end

  def self.get_products_list_id_from_feature_id(mobile_brand_id)

    find(mobile_brand_id).mobiles.map &:mobiles_list_id

  end

end

