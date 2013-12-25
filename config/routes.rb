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

  namespace :admin do
    resources :users
    resources :orders
    resources :products
    resources :categories

    get :index
  end

  root :to => 'pages#home'
end
