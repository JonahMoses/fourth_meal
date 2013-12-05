require 'spec_helper'

describe "viewing an individual restaurant menu", :type => :feature do

  xit "shows a menu" do
    visit '/'
    expect(page).to have_content 'FOOD FIGHT'
    click_link_or_button("View Menu") # not finding anything
    expect(page).to have_content 'hello'
  end

end

describe RestaurantsController do

  describe 'restaurant root' do
    it 'should work' do
      restaurant = Restaurant.create(:title => "Restaurant 1", :description => "GOOD FOOD")
      visit restaurant_name_path(restaurant.slug)
      expect(page).to have_content(restaurant.title)
    end
  end

end
