class CreateCustomerCareEntriesComments < ActiveRecord::Migration
   def up

  execute "DROP TABLE IF EXISTS customer_care_entries_comments"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS customer_care_entries_comments (
  customer_care_entries_comments_id BIGINT UNSIGNED AUTO_INCREMENT,
  customer_care_entries_id BIGINT UNSIGNED NOT NULL,
  customer_phone_no VARCHAR(255) NOT NULL,
  comments TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (customer_care_entries_comments_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE IF EXISTS customer_care_entries_comments"
  end
end
