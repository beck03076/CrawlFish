class BooksF7Publisher < ActiveRecord::Base

     has_many :publisherlinks , :class_name => "LinkF7BooksLists", :foreign_key => "publisher_id"
     has_many :books, :through => :publisherlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

     def self.get_publishers(publisher_id)

       where("publisher_id IN (?)", publisher_id ).select("publisher").map {|v| v.publisher}

     end

     def self.get_books_count_excluding_specific_product(publisher_id,books_list_id)

       find(publisher_id).books.where("books_lists.books_list_id != ? AND books_lists.books_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 1)",books_list_id).select("COUNT(*) as publisher_count,publisher_id")

     end

     def self.get_products_list_id_from_feature_id(publisher_id)

        find(publisher_id).books.map &:books_list_id

     end


end

