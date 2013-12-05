require 'spec_helper'

describe Restaurant do

  it "creates a restaurant with status being true" do
    restaurant = Restaurant.create(:title => "ABC Restaurant", :description => "GOOD FOOD")
    restaurant.status.should eq(true)
  end

  it "knows if restaurant is not active" do
    Restaurant.create(:title => "ABC Restaurant", :description => "GOOD FOOD", :status => false)
    Restaurant.active.should be_empty
  end

  it "knows if restaurant is active" do
    Restaurant.create(:title => "ABC Restaurant", :description => "GOOD FOOD")
    Restaurant.active.should be_true
  end

  it "should have a slug" do
    restaurant = Restaurant.create(:title => "ABC's Restaurant:", :description => "GOOD FOOD")
    restaurant.slug.should eq("abc-s-restaurant")

    target = Restaurant.find_by(slug: "abc-s-restaurant")
    target.should eq restaurant
  end

end
