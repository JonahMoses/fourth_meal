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
      restaurant = FactoryGirl.create(:restaurant)
      visit restaurant_name_path(restaurant.slug)
      expect(page).to have_content(restaurant.title)
    end
  end

  describe 'add item to cart refresh menu page' do
    it 'should update cart'do
      restaurant = FactoryGirl.create(:restaurant)
      item = FactoryGirl.create(:item, restaurant_id: restaurant.id)
      visit restaurant_name_path(restaurant.slug)
        click_link_or_button('Add to Cart')
        expect(page).to have_content 'View Items in Cart: 1'
    end
  end


end
