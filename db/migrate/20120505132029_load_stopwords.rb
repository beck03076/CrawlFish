class LoadStopwords < ActiveRecord::Migration
  def up

	execute <<-SQL
	LOAD DATA LOCAL INFILE '/home/vijayaragavanv/rubyonrails/CrawlFish_2013Mar20/CrawlFish/db/sphinx/data/stopwords.txt' INTO TABLE stopwords(stopword) set created_at=CURRENT_TIMESTAMP;
	SQL

  end

  def down
	execute "DELETE FROM stopwords"
  end
end
