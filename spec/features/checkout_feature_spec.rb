require 'spec_helper'

describe "the checkout process" do

  # before :all do
  #   register_user
  #   make_an_item
  #   add_item_to_order
  # end

  xit "updates order and directs to confirmation page" do
    visit '/orders'
    click_on 'Show'
    click_on 'Purchase'
    within('.confirmation-banner') do
      expect(page).to have_content 'Confirmation'
    end
  end

  it "offers guest checkout option if not signed in" do
    new_restaurant = FactoryGirl.create(:restaurant)
    new_item = FactoryGirl.create(:item, restaurant_id: new_restaurant.id)
    visit "/#{new_restaurant.slug}"
    click_on('Add to Cart')
    click_link_or_button('Purchase')
    click_link_or_button('Checkout as Guest')
  end

end

describe "the checkout process for a guest" do

  before do
    new_restaurant = FactoryGirl.create(:restaurant)
    new_item = FactoryGirl.create(:item, restaurant_id: new_restaurant.id)
    visit "/#{new_restaurant.slug}"
    click_on('Add to Cart')
    click_link_or_button('Purchase')
    click_link_or_button('Checkout as Guest')
  end

  describe 'with invalid info' do
    it "redirects back and requires all fields" do
      click_on 'Checkout'
      page.should have_content 'email required'
    end
  end

  describe 'with valid info' do
    it 'redirecurcts to confirmation page' do
      fill_in "user_email", with: "blair@exampl.com"
      click_on('Checkout')
      expect(page).to have_content("Confirmation")
    end
  end

end

describe "making a new order after purchasing an order" do

  # before :all do
    #make_an_item_via_db
  # end

  xit "should create a new order after purchasing" do
    register_user
    add_item_to_order
    visit '/orders'
    click_on 'Show'
    click_on 'Purchase'
    add_item_to_order
    within('.item_quantity') do
      expect(page).to have_content('1')
    end
  end

end
