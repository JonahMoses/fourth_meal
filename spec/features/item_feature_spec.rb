require 'spec_helper'


  describe "Viewing individual item" do

    it "should have the item title" do
      restaurant = FactoryGirl.create(:restaurant)
      item = FactoryGirl.create(:item, restaurant_id: restaurant.id)
      visit "/#{restaurant.slug}/#{item.id}"
      expect(page).to have_content(item.title)
    end

  end


