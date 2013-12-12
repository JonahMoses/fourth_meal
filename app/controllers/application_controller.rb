class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method              :current_user, :order_items_count, :current_restaurant
  delegate                   :allow?, to: :current_permission
  helper_method              :allow?
  before_action              :authorize
  before_action              :all_restaurants

private

  def order_items_count
    if current_user
      current_cart = Order.find_unsubmitted_order_for(current_user.id, current_restaurant.id)
      current_cart.items_count if current_cart
    else
      0
    end
  end

  def current_restaurant
    @restaurant = Restaurant.find_by(slug: params[:slug])
  end

  def current_order
    @current_order ||= Order.find(session[:order_id]) if session[:order_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def all_restaurants
    @restaurants ||= Restaurant.all
  end

  def create_and_log_in_guest_user
    session[:user_id] ||= User.new_guest_user_id
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action])
      redirect_to "/", alert: "Not authorized"
    end
  end

end
