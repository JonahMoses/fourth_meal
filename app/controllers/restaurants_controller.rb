class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.active
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def show
    @restaurant = current_restaurant
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id)
  end

end
