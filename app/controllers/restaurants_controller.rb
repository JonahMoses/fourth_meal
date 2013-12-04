class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.active
  end




end
