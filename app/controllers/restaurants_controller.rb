class RestaurantsController < ApplicationController
  before_action :create_and_log_in_guest_user, only: [:show]

  def index
    @restaurants = Restaurant.active
    @current_user = current_user
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def show
    @current_order = current_restaurant.orders.find_unsubmitted_order_for(@current_user, current_restaurant.id)
    @current_restaurant = current_restaurant
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id)
  end

end
