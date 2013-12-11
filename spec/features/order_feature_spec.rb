require 'spec_helper'

describe "a logged in user's order" do

  it "shows the added item in the order" do
    log_in_user
    add_item_to_order
    expect(page).to have_content 'Successfully added product to cart'
  end
end

describe "a guest user's order" do

  it "adds item to an order" do
    add_item_to_order
    click_on 'View Items in Cart: 1'
    expect(page).to have_content 'unsubmitted'
    expect(page).to have_content "#{@restaurant.title}"
  end

  it "creates new order when add item to cart in different restaurant" do
    add_item_to_order
    expect(page).to have_content "#{@restaurant.title}"
    new_restaurant = FactoryGirl.create(:restaurant)
    new_item = FactoryGirl.create(:item, restaurant_id: new_restaurant.id)
    visit "/#{new_restaurant.slug}"
    click_on('Add to Cart')
    expect(page).to have_no_content("ABC")
    expect(page).to have_content("Bacon")
  end

  it "has unique cart for each restaurant" do
    new_restaurant = FactoryGirl.create(:restaurant)
    new_item = FactoryGirl.create(:item, restaurant_id: new_restaurant.id)
    visit "/#{new_restaurant.slug}"
    click_on('Add to Cart')
    expect(page).to have_content("Bacon")
        new_restaurant2 = FactoryGirl.create(:restaurant, title: "Parsley", description: "blah balh")
        new_item2 = FactoryGirl.create(:item, restaurant_id: new_restaurant2.id, title: "brown fried food", description: "fried brown food")
    visit "/#{new_restaurant2.slug}"
    click_on('Add to Cart')
    expect(page).to have_no_content("Bacon")
    expect(page).to have_content("fried brown food")
  end

  xit "keeps item in cart after signing up" do
    add_item_to_order
    click_on("View Items")
    expect(page).to have_content 'unsubmitted'
    click_on('Become a member')
    register_new_user
    within('#flash_notice') do
      expect(page).to have_content 'Signed up!'
    end

    # Currently Create User button goes to
    # /orders and the "Show" button there
    # is trying to go to /orders/45 which doesn't exists anymore

    click_on("Show")
    within('#order_items_index_table') do
      expect(page).to have_content 'unsubmitted'
    end
    within('#order_items_table') do
      expect(page).to have_content 'fries'
    end
  end

end

describe "maintaining a single cart over multiple logins" do

  it "keeps same cart for a user after log out and log back in" do
    register_user #=> user@example.com
    add_item_to_order
    click_on('Log Out')
    register_user #=> user@example.com
    visit("/#{@restaurant.slug}")
    click_on("Add to Cart")
    click_on("View Items")
    expect(page).to have_content('2')
  end

end
