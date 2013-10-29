class InsertConversations < ActiveRecord::Migration
  def up


   execute "insert into conversations(conversation, validity,priority, created_at)
   values('To know who we are, visit About Us', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('CrawlFish is an unique price comparison website', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('We are first indian location based price search engine', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('On Day one, we start listing merchants from Chennai, India', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('To know how to search better, visit CrawlFish 101', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Did you check Price Finder in our website?', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Currently, CrawlFish lists 4 online shopping portals', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Shopping with us is an experience to share, SPEAK TO US!', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Are you looking to grow your business? Visit Merchant Login', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('CSMWorld, Velachery is added as a new merchant', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('CSMWorld sells all phone models of Nokia, Samsung, Micromax', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Unique Cell Care is added as a new merchant', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Do you have questions about us? Visit FAQ', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Do you have any suggestions? SPEAK TO US!', 1,1 , current_timestamp)"


  end

  def down
  execute "DELETE FROM conversations"
  end
end

