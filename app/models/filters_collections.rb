class FiltersCollections  < ActiveRecord::Base

  define_index do

    indexes filter_key

  end

  attr_accessor :matched_filter_keys

  @@matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

  def self.filter_search(master_hash,filter_key,sub_category_id,products_list_id_hash)

    filter_details = []

    with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    filter_details = (search(filter_key,:match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => { 'filter' => 1, :sub_category_id => sub_category_id  }))

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end

  def self.surface_search(master_hash,sphinx_search_key,products_list_id_hash)

    with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    filter_details =  (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1})

    insert_filter_details_into_master_hash(master_hash,filter_details,products_list_id_hash)

  end

  def self.deep_search_plus(master_hash,
                            sphinx_search_key)

    #with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    filter_details =  (search  sphinx_search_key)

    insert_filter_details_into_master_hash(master_hash,
                                           filter_details)

  end

  def self.deep_search_minus(master_hash,
                             sphinx_search_key)

    filter_details = []

    filter_details = (search  sphinx_search_key, :match_mode => :any)

    insert_filter_details_into_master_hash(master_hash,
                                           filter_details)

  end

  def self.insert_filter_details_into_master_hash(m_h,
                                                  filter_details)

    filter_details.each do |i|
    
         conditions = [ ]
         
         id = i.sub_category_id
         
       if m_h.keys.include?(id)
         
         p_id = Subcategories.find(id).sub_category_name.slice(0..-2) + "_id"

                  conditions << i.filter_table_column
                  conditions << ' IN  ('
                  conditions << i.filter_id
                  conditions << ')'
                  conditions = conditions.join

             
             m_h = self.fetch_filter_details(m_h,
                                             conditions,
                                             p_id,
                                             id,
                                             i.filter_key,
                                             i.filter_table_name,
                                             i.filter_table_column)

          
       end

    end

    m_h

  end

  def self.get_matched_filter_keys

    @@matched_filter_keys

  end

  def self.flush_matched_filter_keys

    @@matched_filter_keys = Hash.new{|hash, key| hash[key] = Array.new}

  end

  def self.fetch_filter_details(master_hash,
                                conditions,
                                products_list_id,
                                sub_category_id,
                                filter_key,
                                filter_table_name,
                                filter_table_column)

        @@matched_filter_keys[sub_category_id] <<  [filter_key,
                                                    filter_table_column]

        current_products_list_id = filter_table_name.camelize.constantize.where(conditions).select(products_list_id).map {|x| x.send(products_list_id)}

        if !(current_products_list_id.flatten.empty?)

          master_hash[sub_category_id][:filter]  << current_products_list_id

        end

        master_hash

  end

end

