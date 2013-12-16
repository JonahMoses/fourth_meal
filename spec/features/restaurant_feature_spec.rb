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

    it 'should not display inactive restaurants' do
      restaurant1 = FactoryGirl.create(:restaurant, status: "active")
      restaurant2 = FactoryGirl.create(:restaurant, title: "Antony's")
      restaurant3 = FactoryGirl.create(:restaurant, title: "WTPho", status: "inactive")
      visit restaurants_path
      expect(page).to have_no_content(restaurant3.title)
      expect(page).to have_content(restaurant1.title)
    end

    it 'should display a Create New Restaurant link for authenticated users' do
      restaurant = FactoryGirl.create(:restaurant)
      register_user
      visit restaurants_path
      find_button 'Create New Restaurant'
      click_on 'Log Out'
      expect(page).not_to have_content 'Create New Restaurant'
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

  describe 'create a new restaurant' do
    it 'should have a form for user to fill out with restaurant info' do
      register_user
      visit restaurants_path
      click_button 'Create New Restaurant'
      expect(page).to have_content 'New Restaurant Form'
      expect(page).to have_content 'Restaurant name'
      expect(page).to have_content 'Restaurant description'
      fill_in "restaurant_title", with: "Tito's1"
      fill_in "restaurant_description", with: "Jorge's favorite place"
      click_button('Create Restaurant')
      expect(page).to have_content "Restaurant is submitted and pending approval"
    end
  end

    it "creator id should be current user id" do
      user = User.where(:email => "user@example.com").first_or_create(
               :email => "user@example.com",
               :full_name => "bo jangles",
               :display_name => "bj",
               :password => "foobarbaz",
               :password_confirmation => "foobarbaz")
      visit '/log_in'
      fill_in 'email',    :with => "user@example.com"
      fill_in 'password', :with => "foobarbaz"
      click_button 'Log In'
      visit restaurants_path
      click_button 'Create New Restaurant'
      fill_in "restaurant_title", with: "Tito's2"
      fill_in "restaurant_description", with: "Jorge's favorite place"
      click_button('Create Restaurant')
      restaurant = Restaurant.first
      expect(restaurant.creator_id).to eq user.id
      expect(restaurant.jobs.count).to eq 1
      expect(restaurant.jobs.last.restaurant_id).to eq restaurant.id
      expect(restaurant.jobs.last.user_id).to eq user.id
      expect(restaurant.jobs.last.role).to eq "Creator"
      click_on "Log Out"
      expect(page).to have_content("Logged out")
      click_on "Log In"
      register_admin_user
      expect(page).to have_content("Logged in")
      visit "/dashboard"
      click_on "Approve"
      expect(restaurant.jobs.last.role).to eq "Admin"
    end

    it 'should show My Restaurants on users Nav bar when approved' do
      user = User.where(:email => "user@example.com").first_or_create(
               :email => "user@example.com",
               :full_name => "bo jangles",
               :display_name => "bj",
               :password => "foobarbaz",
               :password_confirmation => "foobarbaz")
      visit '/log_in'
      fill_in 'email',    :with => "user@example.com"
      fill_in 'password', :with => "foobarbaz"
      click_button 'Log In'
      visit restaurants_path
      click_button 'Create New Restaurant'
      fill_in "restaurant_title", with: "Tito's3"
      fill_in "restaurant_description", with: "Jorge's favorite place"
      click_button('Create Restaurant')
      restaurant = Restaurant.first
      expect(restaurant.creator_id).to eq user.id
      expect(restaurant.jobs.count).to eq 1
      expect(restaurant.jobs.last.restaurant_id).to eq restaurant.id
      expect(restaurant.jobs.last.user_id).to eq user.id
      expect(restaurant.jobs.last.role).to eq "Creator"
      click_on "Log Out"
      expect(page).to have_content("Logged out")
      click_on "Log In"
      register_admin_user
      expect(page).to have_content("Logged in")
      visit "/dashboard"
      click_on "Approve"
      expect(restaurant.jobs.last.role).to eq "Admin"
      click_on "Log Out"
      visit '/log_in'
      fill_in 'email',    :with => "user@example.com"
      fill_in 'password', :with => "foobarbaz"
      click_button "Log In"
      expect(page).to have_content("My Restaurants")
      end

      it 'should show My Restaurants on users Nav bar when approved' do
      user = User.where(:email => "user@example.com").first_or_create(
               :email => "user@example.com",
               :full_name => "bo jangles",
               :display_name => "bj",
               :password => "foobarbaz",
               :password_confirmation => "foobarbaz")
      visit '/log_in'
      fill_in 'email',    :with => "user@example.com"
      fill_in 'password', :with => "foobarbaz"
      click_button 'Log In'
      visit restaurants_path
      click_button 'Create New Restaurant'
      fill_in "restaurant_title", with: "Tito's4"
      fill_in "restaurant_description", with: "Jorge's favorite place"
      click_button('Create Restaurant')
      restaurant = Restaurant.first
      expect(restaurant.creator_id).to eq user.id
      expect(restaurant.jobs.count).to eq 1
      expect(restaurant.jobs.last.restaurant_id).to eq restaurant.id
      expect(restaurant.jobs.last.user_id).to eq user.id
      expect(restaurant.jobs.last.role).to eq "Creator"
      click_on "Log Out"
      expect(page).to have_content("Logged out")
      click_on "Log In"
      register_admin_user
      expect(page).to have_content("Logged in")
      visit "/dashboard"
      click_on "Approve"
      expect(ActionMailer::Base.deliveries.length).to eq(2)
      # 2 emails as user gets email when submitting email as well
      end

end
