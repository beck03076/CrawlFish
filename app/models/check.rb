class Check < ActiveRecord::Base
  define_index do
    indexes name
  end
  attr_accessible :name
end
