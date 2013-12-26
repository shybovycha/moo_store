MooShop::Application.routes.draw do
  root :to => 'pages#home'

  devise_for :users, :controllers => { :registrations => "users/registrations" }
  resources :categories

  resources :orders, :except => [ :destroy ]

  resources :products do
    collection do
      get :export
      post :import
    end
  end

  scope :pages, :path => 'pages' do
    get 'home', :to => 'pages#home', :as => 'home'
    get 'contacts', :to => 'pages#contacts', :as => 'contacts'
  end

  scope :cart, :path => 'cart' do
    get 'add/:product_id' => 'cart#add_to_cart', :as => 'add_to_cart'
    get 'remove/:product_id' => 'cart#remove_from_cart', :as => 'remove_from_cart'
    get '/' => 'cart#show', :as => 'cart'
    get 'checkout' => 'cart#checkout', :as => 'checkout'
  end

  namespace :admin do
    resources :users
    resources :orders, :only => [ :edit, :index ]
    resources :products
    resources :categories, :only => [ :new, :edit, :index ]

    get :index
  end
end
