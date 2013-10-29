class BooksF1Author < ActiveRecord::Base
     has_many :authorlinks , :class_name => "LinkF1BooksLists", :foreign_key => "author_id"
     has_many :books, :through => :authorlinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

     has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
     has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

     def self.get_books_count_excluding_specific_product(author_id,books_list_id)

       find(author_id).books.where("books_lists.books_list_id != ? AND books_lists.books_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 1)",books_list_id).select("COUNT(*) as author_count,author_id")

     end

     def self.get_products_list_id_from_feature_id(author_id)

       find(author_id).books.map &:books_list_id

     end

end

