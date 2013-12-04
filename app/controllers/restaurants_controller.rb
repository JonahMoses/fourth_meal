class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.active
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def show
    @restaurant = Restaurant.find_by(title: params[:title])
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :id)
  end

end
