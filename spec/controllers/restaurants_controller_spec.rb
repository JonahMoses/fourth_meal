require 'spec_helper'

describe RestaurantsController do

  it "routes to /" do
   expect(:get => "/").to route_to(
          :controller => "restaurants",
          :action => "index",
   )
  end
end

# describe ApplicationController do

#   it "it knows current_restaurant" do
#     restaurant = Restaurant.create(:title => "This Restaurant", :description => "hello world")
#     visit "/#{restaurant.slug}"
#     expect(restaurant).to eq(current_restaurant)
#   end

# end
