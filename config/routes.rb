require 'sidekiq/web'
require 'admin_constraint'

Foodfight::Application.routes.draw do
  post "/guest_confirm_purchase" => "orders#guest_confirm_purchase", as: :guest_confirm_purchase
  get "/guest" => "orders#guest_purchase", as: :guest_purchase
  get "dashboard" => "dashboard#index", :as => 'dashboard'
  put "/:slug/approve" => "restaurants#approve", :as => :approve_restaurant

  resources :categories

  root :to => "restaurants#index"

  resources :orders do
    get 'confirmation', on: :member
  end

  resources :order_items, except: [:update]
  patch ":slug/order/:id/order_items/:item_id", to: "order_items#update", as: :update_order_item

  post "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"


  resources :users do
    get :purchase, on: :collection
  end

  resources :sessions
  get "/code" => redirect("https://github.com/JonahMoses/dinner_dash")
  resources :item_categories
  resources :items, except: [:index, :show, :new]

  resources :restaurants
  get ":slug",                      to: "restaurants#show",     as: :restaurant_name
  post ":slug/order/:item_id",      to: "order_items#create",   as: :create_restaurant_order
  get ":slug/order/:id",            to: "orders#show",          as: :restaurant_order
  delete ":slug/order/:id",         to: "orders#destroy",       as: :destroy_restaurant_order
  post ":slug/orders/:id/purchase", to: "orders#purchase",      as: :purchase_order
  get ":slug/details",              to: "restaurants#details",  as: :restaurant_details
  get ":slug/:id",                  to: "items#show",           as: :restaurant_item
  get ":slug/items/new",            to: "items#new",            as: :new_restaurant_item


  mount Sidekiq::Web, at: '/sidekiq', :constraints => AdminConstraint.new

end
