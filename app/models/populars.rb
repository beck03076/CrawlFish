class Populars < ActiveRecord::Base
  attr_accessible :brand, :category, :name, :p_l_id
  
  def self.one(c = "mobiles_lists")
  
    where(:category => c).order("rand()").select(:name).first.name.titleize
  
  end
  
end
