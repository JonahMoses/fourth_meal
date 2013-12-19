require 'spec_helper'


  describe "Viewing individual item" do

    it "should have the item title" do
      user = FactoryGirl.create(:user)
      restaurant = FactoryGirl.create(:restaurant)
      item = FactoryGirl.create(:item, restaurant_id: restaurant.id)
      visit "/Bryana-s/1"
      # save_and_open_page
      expect(page).to have_content(item.title)
    end

  end


