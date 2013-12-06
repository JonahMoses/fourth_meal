class RestaurantsController < ApplicationController
  before_action :create_and_log_in_guest_user, only: [:show]

  def index
    @restaurants = Restaurant.active
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def show
    @restaurant = current_restaurant
    @restaurant_order = current_user.orders.order("created_at DESC")
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id)
  end

end
