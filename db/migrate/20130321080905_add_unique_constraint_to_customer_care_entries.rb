class AddUniqueConstraintToCustomerCareEntries < ActiveRecord::Migration

  def up

	execute <<-SQL
		ALTER TABLE customer_care_entries ADD CONSTRAINT cce_name_phone UNIQUE (customer_name,customer_phone_no)
  	SQL

	execute <<-SQL
		ALTER TABLE customer_care_entries ADD CONSTRAINT cce_name_email UNIQUE (customer_name,customer_email)
  	SQL

  end

  def down

	execute "ALTER TABLE customer_care_entries DROP INDEX cce_name_phone"
	execute "ALTER TABLE customer_care_entries DROP INDEX cce_name_email"

  end

end
