class ProductsFilterCollections < ActiveRecord::Base

  include SearchModule

  define_index do

    indexes filter_key

  end

  attr_accessor :matched_title_keys

  @@unmatched_title_keys =  Array.new

  def self.plain_exact_search(sphinx_search_key)

    #with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount)

  end

  def self.exact_search(sphinx_search_key,sub_category_id)

    with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    (search  sphinx_search_key, :match_mode => :extended, :rank_mode => :wordcount, :sphinx_select => with_filter, :with => {'filter' => 1 , :sub_category_id => sub_category_id }).first.filter_id

  end

  def self.surface_search(m_h,sphinx_search_key)

    with_filter = "*, IF( @weight =  word_count,1,0) AS filter"

    m_h.keys.each do |i|

      result_set =  (search  sphinx_search_key,
                             :match_mode => :extended,
                             :rank_mode => :wordcount,
                             :sphinx_select => with_filter,
                             :with => {'filter' => 1,
                             :sub_category_id => i }).map &:filter_id
                     
      if !(result_set.nil?)
      
        m_h[i][:final] = result_set +  m_h[i][:final]
        
      end
      
    end

    m_h

  end

  def self.deep_search_plus(m_h,sphinx_search_key)

    #with_filter = "*, IF( @weight >=  word_count,1,0) AS filter"

    m_h.keys.each do |i|

      @result_set =  (search  sphinx_search_key)

      m_h[i][:title] = @result_set.map &:filter_id

    end

    sphinx_results = @result_set.results

      sphinx_results[:words].keys.each do |word|

        if sphinx_results[:words][word][:hits] == 0

          @@unmatched_title_keys << word

        end

      end

    m_h

  end

  def self.deep_search_minus(m_h,sphinx_search_key)

    m_h.keys.each do |i|

      m_h[i][:title] =  (search  sphinx_search_key, :match_mode => :any).map &:filter_id

    end

    m_h

  end

  def self.get_unmatched_title_keys

    @@unmatched_title_keys.join(" ")

  end

  def self.flush_unmatched_title_keys

    @@unmatched_title_keys = Array.new

  end


  def self.get_names_for_quick_search(search_key)
	
	where("filter_key like ?",search_key).select("DISTINCT(filter_key)").map{|i| [i.filter_key.titlecase]}

  end

end

