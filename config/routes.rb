require 'sidekiq/web'
require 'admin_constraint'

Foodfight::Application.routes.draw do
  get "/guest" => "orders#guest_purchase", as: :guest_purchase
  get "dashboard" => "dashboard#index", :as => 'dashboard'
  resources :categories

  root :to => "restaurants#index"

  resources :orders do
    post 'purchase', :on => :member
    get 'confirmation', :on => :member
  end

  resources :order_items
  # , except: [:edit]
  # get ":slug/order/:id/:item_id", to: "order_items#edit", as: :order_item_edit

  post "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"

  resources :users
  resources :sessions
  get "/code" => redirect("https://github.com/JonahMoses/dinner_dash")
  resources :item_categories
  resources :items, except: [:index, :show]

  resources :restaurants
  get ":slug", to: "restaurants#show", as: :restaurant_name
  get ":slug/:id", to: "items#show", as: :restaurant_item
  post ":slug/order/:item_id", to: "order_items#create", as: :create_restaurant_order
  get ":slug/order/:id", to: "orders#show", as: :restaurant_order

  mount Sidekiq::Web, at: '/sidekiq', :constraints => AdminConstraint.new
  
end
