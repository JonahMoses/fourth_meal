class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.active
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

private

  def item_params
    params.require(:restaurant).permit(:title, :description)
  end

end
