class RegionsController < ApplicationController

 def show
    @restaurants = Restaurant.where(:status => "active", :region_id => current_region.id).page(params[:page]).per(6)
    @current_user = current_user
  end

end
