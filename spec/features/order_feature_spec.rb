require 'spec_helper'

describe "a logged in user's order" do
  # before :all do
  #   register_user
  #   make_an_item
  # end

  xit "starts with no order" do
    log_in_user
    visit '/orders'
    expect(page).not_to have_content 'unsubmitted'
  end

  xit "shows the added item in the order" do
    log_in_user
    visit '/items'
    click_on('Add to Cart')
    expect(page).to have_content 'unsubmitted'
  end
end

describe "a guest user's order" do
  # before :all do
  #   make_an_item
  # end

  it "adds item to an order" do
    add_item_to_order
    expect(page).to have_content 'unsubmitted'
    expect(page).to have_content "#{@restaurant.title}"
  end

  it "creates new order when add item to cart in different restaurant" do 
    add_item_to_order
    expect(page).to have_content "#{@restaurant.title}"
    new_restaurant = Restaurant.create(
      :title => "New Restuarant",
      :description => "GOOD FOOD")
    new_item = Item.create(
      :title => "Bacon",
      :description => "Yummy",
      :price => "$10.09",
      :restaurant_id => new_restaurant.id)
    #add buttons to go back to other restaurant
    visit "/#{new_restaurant.slug}"
    click_on('Add to Cart')
    expect(page).to have_no_content("ABC")
    expect(page).to have_content("Bacon")
  end

  xit "keeps item in cart after signing up" do
    add_item_to_order
    #within("#order_items_index_table") do
      expect(page).to have_content 'unsubmitted'
    #end
    click_on('Become a member') # should probably say Become a member (case?)
    register_new_user
    within('#flash_notice') do
      expect(page).to have_content 'Signed up!'
    end
    within('#order_items_index_table') do
      expect(page).to have_content 'unsubmitted'
    end
    click_on('Show')
    within('#order_items_table') do
      expect(page).to have_content 'fries'
    end
  end

end

describe "maintaining a single cart over multiple logins" do
  # before :all do
  #   make_an_item
  # end

  xit "keeps same cart for a user after log out and log back in" do
    register_user #=> user@example.com
    add_item_to_order
    click_on('Log Out')
    register_user #=> user@example.com
    add_item_to_order # is it same item?
    within('.item_quantity') do
      expect(page).to have_content('2')
    end
  end
end
