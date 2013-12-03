require 'spec_helper'

describe SessionsController do

  describe "logging out" do
    it "routes to /log_out" do
      expect(:post => "/log_out").to route_to(
             :controller => "sessions",
             :action => "destroy"
      )
    end
  end

end
