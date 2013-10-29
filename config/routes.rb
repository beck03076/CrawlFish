CrawlFish::Application.routes.draw do

  match '/autocomplete/show' => 'autocomplete#show' 

  match '/price_search/start_search/:search_case' => 'price_search#start_search'
  
  match '/converse.js' => 'Converse#fetch'
  
  match 'category/switch/:sub_category_id' => 'category#index'
  
  match 'local/show_gmap/:vendor_name/:branch_name' => 'local#show_gmap'
  
  match 'local/send_sms/:type/:phone_number/:vendor_id/:product_id/:sub_category_id' => 'local#send_sms'

  match 'local/generate_coupon_code/:phone_number/:vendor_id(/:unique_id/:sub_category_id/:product_id)' => 'local#generate_coupon_code'

  match '/local/change_vendor_details/:vendor_id' => 'local#change_vendor_details'

  match ':controller(/:action(/:id))'
 #=================================SEO Routes========================
  # 2013jun01: senthil: added to make url small, meaningful and unique
  match '/price/:category_name/:product_name' => 'specific#online'
  
  #number of params 4
  match '/online-price-comparison/:category_name/:product_name/:country' => 'specific#online_specific_search'
 #5,1
 match '/price-comparison/:category_name/:product_name/:country/:city(/:area_names)' => 'specific#local_specific_search'

 #7
 match '/price-comparison/:category_name/:product_name/:country/:city/:area_names/:vendor_name(/:list)'=> 'local#show_local_shop'

  #=================================SEO Routes========================
  # 2013jun01: senthil: added to make url small, meaningful and unique
  match '/price-list/:category_name/:brand_name' => 'index_links#show_products'
  match '/price-range/:category_name/:position/:price' => 'index_links#show_products' 

  match '/shops/:category_name/:country/:city' => 'index_links#show_areas'

  match '/shops/:category_name/:country/:city/:area' => 'index_links#show_shops'

  match '/shops/:category_name/:country/:city/:area/:vendor_name' => 'index_links#show_shop_page'

  match '/error/:message' => "error#message"  

  match '/location-in-maps/:category_name/:product_name/:country/:city(/:area_names)' => 'specific#maps'

   match '/update_local_grid/:val/:product_id/:sub_category_id/:excludable_availability_ids/:area_ids/:city/:country/:product_name/:category_name/:kind' => 'specific#update_local_grid'
   
   match '/update_online_grid/:val/:product_id/:sub_category_id/:excludable_availability_ids/:country/:product_name/:category_name/:kind' => 'specific#update_online_grid'

 match '/areas.json' => 'application#set_areas'

 match '/price-comparison/search' => "search#index"

 match '/update_numbers/:city(/:area_ids)' => "main#update_numbers"


 match '/update_online_price' => 'specific#update_online_price'
 
  match '/grab_price' => 'specific#grab_price'

  match '/shops-list/:country/:city(/:area)' => 'index_links#show_shops_list'
  
  match '/shops-list/:country/:city/:area/:vendor_name(/:list)' => 'shop#show'
  
  match '/pop/:cat' => 'main#pop'
  
   match '/asker/:shop/:vendor_id/:city/:country/:product_name/:identifier/:category_name' => 'specific#vendor_rating'
   
   match '/asker/:shop/:vendor_id/:product_name/:identifier/:category_name' => 'specific#vendor_rating'
   
   match '/viewed/:ids' => 'search#viewed'
   
   match "/about" => "footer#about"
   
   match "/we-love-creativity" => "footer#creativity"
   
   match "/blog" => "footer#blog"
   
   match "/complain" => "footer#complain"
   
   match "/specific/redirect/:vendor_id/:product_id/:sub_category_id/:product_name/:vendor_name" => "specific#redirect"
   

 unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'main#index'
  # See how all your routes lay out with "rake routes"


  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

