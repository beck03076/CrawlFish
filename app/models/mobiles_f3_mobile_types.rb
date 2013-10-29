class MobilesF3MobileTypes < ActiveRecord::Base

  has_many :mobile_type_links , :class_name => "LinkF3MobilesLists", :foreign_key => "mobile_type_id"
  has_many :mobiles, :through => :mobile_type_links, :class_name => "MobilesLists" , :foreign_key => "mobiles_list_id"


  def self.get_display_name(mobile_type_id)

    where("mobile_type_id IN (?)", mobile_type_id ).select("mobile_type_name").map {|v| v.mobile_type_name}

  end

  def self.get_mobiles_count_excluding_specific_product(mobile_type_id,mobiles_list_id)

    inner_query = MobilesF3MobileType.find(mobile_type_id).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobiles_list_id).select("COUNT(*) AS a,link_f3_mobiles_lists.mobile_type_id AS b").group("mobiles_lists.mobile_name")

    outer_query = MobilesF3MobileType.scoped

    outer_query = outer_query.from(Arel.sql("(#{inner_query.to_sql}) as results")).select("COUNT(*) AS mobile_type_count,b AS mobile_type_id")

      # find(mobile_type_id).mobiles.where("mobiles_lists.mobiles_list_id != ? AND mobiles_lists.mobiles_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 2)",mobiles_list_id).group("mobiles_lists.mobile_name").size.count

  end

  def self.get_products_list_id_from_feature_id(mobile_type_id)

    find(mobile_type_id).mobiles.map &:mobiles_list_id

  end


end

