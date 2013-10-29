class BooksF2Genres < ActiveRecord::Base
  has_many :genrelinks , :class_name => "LinkF2BooksLists", :foreign_key => "genre_id"
  has_many :books, :through => :genrelinks, :class_name => "BooksList" , :foreign_key => "books_list_id"

  has_one :filtercollectionid, :class_name => "FiltersCollection", :foreign_key => "filter_id"
  has_one :filtercollectionname, :class_name => "FiltersCollection", :foreign_key => "filter_key"

  def self.get_genre_names(genre_id)

    where("genre_id IN (?)", genre_id ).select("genre_name").map {|v| v.genre_name}

  end

  def self.get_books_count_excluding_specific_product(genre_id,books_list_id)

     find(genre_id).books.where("books_lists.books_list_id != ? AND books_lists.books_list_id IN (SELECT products_list_id FROM link_products_lists_vendors WHERE sub_category_id = 1)",books_list_id).select("COUNT(*) as genre_count,genre_id")

  end

  def self.get_products_list_id_from_feature_id(genre_id)

    find(genre_id).books.map &:books_list_id

  end



end

