require 'spec_helper'

describe "viewing an individual restaurant menu", :type => :feature do

  it "shows a menu" do
    create_restaurant_with_item
    visit "/#{@restaurant.slug}"
    expect(page).to have_content "#{@restaurant.title}"
    expect(page).to have_content 'Add to Cart'
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
