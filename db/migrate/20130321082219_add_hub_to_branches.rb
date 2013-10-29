class AddHubToBranches < ActiveRecord::Migration

  def up

	execute <<-SQL
		ALTER TABLE branches ADD hub CHAR(1) DEFAULT 'n' AFTER branch_name
  	SQL

  end

  def down

	execute "ALTER TABLE branches DROP COLUMN hub"

  end

end
