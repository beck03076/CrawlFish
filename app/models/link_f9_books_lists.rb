class LinkF9BooksLists < ActiveRecord::Base

  belongs_to :books, :class_name => "BooksList", :foreign_key => "books_list_id"
  belongs_to :languages, :class_name => "BooksF9Language", :foreign_key => "language_id"

  #function to obtain similar book with language as additional factor with genre
  #added on 2012aug02 by vijay
  def self.get_similar_books_list_id(product_id,sub_category_id)

    joins("INNER JOIN link_f9_books_lists AS bl2
            ON link_f9_books_lists.language_id = bl2.language_id
            INNER JOIN books_f9_languages AS g2
            ON bl2.language_id = g2.language_id
	    INNER JOIN link_products_lists_vendors
            ON link_products_lists_vendors.products_list_id =
            link_f9_books_lists.books_list_id").where("bl2.books_list_id = ?
            AND link_products_lists_vendors.sub_category_id = ?
            AND products_list_id != ?",product_id,
            sub_category_id,product_id).select("DISTINCT(link_f9_books_lists.books_list_id)
            AS products_list_id").map &:products_list_id


  end

end

