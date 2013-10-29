module MainHelper

  def form_header_links(home_id,price_finder_id,cf_101_id,media_id)

    home_link = link_to "Home",{:controller => "main",:action => "index" },:id => home_id

    price_finder_link = link_to "Price Finder",{:controller => "price_search",:action => "index"},:id => price_finder_id

    cf_101_link = link_to "CrawlFish 101",{:controller => "footer",:action => "faq"},:id => cf_101_id

    media_link = link_to "Media",{:controller => "footer",:action => "media"},:id => media_id

    books_link = link_to "Mobiles & Tablets",{:controller => "search",:action => "index",:query=>"mobiles",:search_case => "products"},:title=> "Click here to visit Mobiles & Tablets index page"

    mobiles_link = link_to "Books",{:controller => "search",:action => "index",:query=>"books",:search_case => "products"},:title=>"Click here to visit Books index page"

    return  '<ul class="cf-home-header-links">  <li>' + home_link  + '
            </li> <li>' + price_finder_link + '
            </li> <li>' + cf_101_link + '
            </li> <li>' + media_link + '
            </li></ul>
            <ul class="cf-home-header-links-right">
            <li>' + books_link + '
            </li> <li>|</li> <li>' + mobiles_link + '
            </li> </ul>'



  end

  def form_categories_links(exclude)

    links = Subcategories.all.map{|i| i.category_name} - [exclude]



  end

end

