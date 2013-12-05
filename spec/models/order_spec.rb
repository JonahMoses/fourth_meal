require 'spec_helper'

describe Order do

  before :each do
    @restaurant = Restaurant.create(
      :title => "Magic Restaurant",
      :description => "GOOD FOOD")
  end

  it "finds the unsubmitted order" do
    user = User.create(:email => "dragons@example.com", :full_name => "yes sir",
                       :password => "foobar", :password_confirmation => "foobar")
    result = @restaurant.orders.create(:user_id => user.id, :restaurant_id => @restaurant.id, :status => "unsubmitted")
    @restaurant.orders.create(:user_id => user.id, :status => "gary")
    found_orders = @restaurant.orders.find_unsubmitted_order_for(user.id)
    expect(result.status).to eq "unsubmitted"
    expect(result.restaurant).to eq @restaurant
    found_orders.status.should eq('unsubmitted')
  end

  it "does not accept an order without a restaurant id" do
    order = @restaurant.orders.create(:status => "unsubmitted")
    order.should be_valid
  end

  describe "checkout" do
    it "purchases unsubmitted order" do
      user = User.create(:email => "dragonsBalls@example.com", :full_name => "yes sir",
                         :password => "foobar", :password_confirmation => "foobar")
      order = @restaurant.orders.create!(:user_id => user.id, :status => "unsubmitted")
      order.purchase!
      expect(order.status).to eq('paid')
    end

    it "does not purchases non-unsubmitted order" do
      order = @restaurant.orders.create!(:user_id => 99, :status => "cancelled")
      order.purchase!
      expect(order.status).to eq('cancelled')
    end
  end

end
