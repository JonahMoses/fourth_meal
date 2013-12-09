require 'spec_helper'

describe OrdersController do

  it "routes to :slug/orders/:id/purchase" do
    restaurant = FactoryGirl.create(:restaurant)
    expect(:post => "#{restaurant.slug}/orders/99/purchase").to route_to(
          :controller => "orders",
          :action => "purchase",
          :slug => "bryana-s",
          :id => "99"
   )
  end

  describe "logging out" do
    it "routes to /log_out" do
      expect(:post => "/log_out").to route_to(
             :controller => "sessions",
             :action => "destroy"
      )
    end
  end

end
