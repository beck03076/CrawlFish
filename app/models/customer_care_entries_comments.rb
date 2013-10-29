class CustomerCareEntriesComments < ActiveRecord::Base
	attr_accessible :customer_care_entries_id
	attr_accessible :customer_phone_no
	attr_accessible :comments
end
