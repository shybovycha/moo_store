MooShop::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }

  get 'products/export' => 'products#export', :as => 'export_products'
  post 'products/import' => 'products#import', :as => 'import_products'

  resources :categories

  resources :orders

  resources :products

  get 'pages/home', :as => 'home'
  get 'pages/contacts', :as => 'contacts'

  get 'cart/add/:product_id' => 'cart#add_to_cart', :as => 'add_to_cart'
  get 'cart/remove/:product_id' => 'cart#remove_from_cart', :as => 'remove_from_cart'
  get 'cart' => 'cart#show', :as => 'cart'
  get 'checkout' => 'cart#checkout', :as => 'checkout'

  get 'admin' => 'admin#index', :as => 'admin_index'
  get 'admin/products' => 'admin#products', :as => 'admin_products'
  get 'admin/orders' => 'admin#orders', :as => 'admin_orders'
  get 'admin/users' => 'admin#users', :as => 'admin_users'

  root :to => 'pages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
