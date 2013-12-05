require 'spec_helper'

describe RestaurantsController do

  describe 'restaurant root' do
    it 'should work' do
      restaurant = Restaurant.create(:title => "Restaurant 1", :description => "GOOD FOOD")
      visit restaurant_name_path(restaurant.slug)
      expect(page).to have_content(restaurant.title)
    end
  end

end

