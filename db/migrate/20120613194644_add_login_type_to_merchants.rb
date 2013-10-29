class AddLoginTypeToMerchants < ActiveRecord::Migration
  def up

    execute <<-SQL
      ALTER TABLE merchants ADD login_type VARCHAR(20) DEFAULT "branch" FIRST
    SQL

  end

  def down

    execute "ALTER TABLE merchants DROP login_type"

  end
end

