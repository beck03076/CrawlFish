class CreateLinkF8MobilesLists < ActiveRecord::Migration
  def up

  execute "DROP TABLE IF EXISTS link_f8_mobiles_lists"
  execute <<-SQL
  CREATE TABLE IF NOT EXISTS link_f8_mobiles_lists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  mobiles_list_id BIGINT UNSIGNED NOT NULL,
  card_slot_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (mobiles_list_id,card_slot_id)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;
  SQL
  end

  def down
  execute "DROP TABLE link_f8_mobiles_lists"
  end
end

