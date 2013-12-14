require 'spec_helper'

describe RestaurantsController do

  it "routes to /" do
   expect(:get => "/").to route_to(
          :controller => "restaurants",
          :action => "index",
   )
  end

end

