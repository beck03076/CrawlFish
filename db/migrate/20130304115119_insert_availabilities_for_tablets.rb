class InsertAvailabilitiesForTablets < ActiveRecord::Migration

 def up

	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('imported edition',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('in stock',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('out of stock',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('available',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('pre order',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('forthcoming',now())"
	execute "INSERT INTO tablets_vendor_f2_availabilities(availability,created_at) VALUES('coming soon',now())"

  end

  def down

  end

end
