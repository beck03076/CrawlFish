class AutocompleteController < ApplicationController

skip_before_filter :set_start_time,:set_city,:help_update_numbers

  def show

    list = []

    search_key = params[:term].to_s

    search_key = search_key.gsub(/[^A-Za-z0-9 ]/,"").squeeze(" ").split.uniq.join(" ")

    sphinx_search_key = "#{search_key}"

    titles = ProductsFilterCollections.search(sphinx_search_key)
    
    unique_titles = titles.map{|i| i.filter_key}.uniq

    unique_titles.first(10).each {|i| list << {"label" => i}}

    respond_to do |format|
      format.json {render :json => list.to_json , :layout => false}
    end

  end

end

