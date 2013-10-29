class CreateMobileReviews < ActiveRecord::Migration
def up
    execute "DROP TABLE IF EXISTS mobile_reviews"
    
    execute <<-SQL
    CREATE TABLE mobile_reviews (
      mobile_reviews_list_id BIGINT UNSIGNED AUTO_INCREMENT,
      mobile_name VARCHAR(255) NOT NULL,
      review_landing_external_url TEXT NOT NULL,
      review_landing_video_url TEXT NOT NULL,
      created_at DATETIME NOT NULL,
      updated_at DATETIME DEFAULT NULL,
      PRIMARY KEY (mobile_reviews_list_id),
      UNIQUE(mobile_name)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    SQL

    end
  def down
    execute "DROP TABLE mobile_reviews"
  end
end

