require 'sidekiq/web'
require 'admin_constraint'

Foodfight::Application.routes.draw do
  # todo: slugs shouldn't match images, javascripts, or stylesheets
  # Figure out regex to make that happen

  mount Sidekiq::Web, at: '/sidekiq' #:constraints => AdminConstraint.new
  post "/guest_confirm_purchase" => "orders#guest_confirm_purchase", as: :guest_confirm_purchase
  get "/guest" => "orders#guest_purchase", as: :guest_purchase
  get "dashboard" => "dashboard#index", :as => 'dashboard'
  put "/:slug/approve" => "restaurants#approve", :as => :approve_restaurant
  put "/:slug/reject" => "restaurants#reject", :as => :reject_restaurant

  resources :categories

  resources :regions

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
  resources :item_categories
  resources :items, except: [:index, :show, :new, :create]
  post ":slug/items",               to: "items#create",                   as: :create_item

  resources :restaurants
  get "/my_restaurants",            to: "restaurants#admin_restaurants",  as: :admin_restaurants
  get ":slug",                      to: "restaurants#show",               as: :restaurant_name
  post ":slug/order/:item_id",      to: "order_items#create",             as: :create_restaurant_order
  get ":slug/order/:id",            to: "orders#show",                    as: :restaurant_order
  delete ":slug/order/:id",         to: "orders#destroy",                 as: :destroy_restaurant_order
  post ":slug/orders/:id/purchase", to: "orders#purchase",                as: :purchase_order
  get "/:slug/activate",            to: "restaurants#activate",           as: :activate_restaurant
  get ":slug/details",              to: "restaurants#details",            as: :restaurant_details
  get ":slug/:id",                  to: "items#show",                     as: :restaurant_item
  get ":slug/items/new",            to: "items#new",                      as: :new_restaurant_item

end
