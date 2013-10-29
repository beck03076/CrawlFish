class LinkF4MobilesLists < ActiveRecord::Base

  belongs_to :mobiles, :class_name => "MobilesLists", :foreign_key => "mobiles_list_id"
  belongs_to :mobile_designs, :class_name => "MobilesF4MobileDesign", :foreign_key => "mobile_design_id"


 def self.get_similar_design_unique_id(product_id,sub_category_id,unique_id)

    joins("INNER JOIN link_f4_mobiles_lists AS ml4
ON link_f4_mobiles_lists.mobile_design_id = ml4.mobile_design_id
INNER JOIN link_products_lists_vendors
ON link_products_lists_vendors.products_list_id =
link_f4_mobiles_lists.mobiles_list_id").where("ml4.mobiles_list_id = ?
AND link_products_lists_vendors.sub_category_id = ?
AND link_products_lists_vendors.products_list_id != ? AND link_products_lists_vendors.unique_id IN (?)",product_id,sub_category_id,product_id,unique_id).select("unique_id").map &:unique_id

  end

end
