class RestaurantsController < ApplicationController
  before_action :create_and_log_in_guest_user, only: [:show]

  def index
    @restaurants = Restaurant.active
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def show
    @current_restaurant = current_restaurant
    @current_order = current_order
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id)
  end

end
