class CreateGifts < ActiveRecord::Migration

  def up

  execute <<-SQL

  CREATE TABLE gifts (
      gift_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
      gift_name VARCHAR(255) DEFAULT NULL,
      gift_image_url TEXT DEFAULT NULL,
      gift_external_url TEXT DEFAULT NULL,
      gift_description TEXT DEFAULT NULL,
      active_flag CHAR(1) DEFAULT "n",
      created_at DATETIME DEFAULT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (gift_id)
      ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

  SQL

  end

  def down

    execute "DROP TABLE IF EXISTS gifts"

  end

end
