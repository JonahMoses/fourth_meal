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
    new_restaurant = FactoryGirl.create(:restaurant)
    new_item = FactoryGirl.create(:item, restaurant_id: new_restaurant.id)
    #TODO: add buttons to go back to other restaurant
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
