require 'spec_helper'

describe ItemsController do

  describe "Viewing individual item" do

    it "should have the item title" do
      restaurant = Restaurant.create(
        :title => "ABC Restaurant",
        :description => "GOOD FOOD")
      item = restaurant.items.create(
        :title => "ABC Item",
        :description => "Item Food",
        :price => "$1.09")
      visit "/#{restaurant.slug}/#{item.id}"
      expect(page).to have_content(item.title)
    end

  end

end
