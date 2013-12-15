require 'spec_helper'

describe RestaurantsController do

  it "routes to /" do
   expect(:get => "/").to route_to(
          :controller => "restaurants",
          :action => "index",
   )
  end

  it "a job has a default role" do
    job = Job.create(restaurant_id: 1, user_id: 1)
    expect(job.role).to eq "Creator"
  end

  it "changes the Creator status to Admin when approved" do
    # user = User.where(:email => "user@example.com").first_or_create(
    #            :email => "user@example.com",
    #            :full_name => "bo jangles",
    #            :display_name => "bj",
    #            :password => "foobarbaz",
    #            :password_confirmation => "foobarbaz")
    # visit '/log_in'
    # fill_in 'email',    :with => "user@example.com"
    # fill_in 'password', :with => "foobarbaz"
    # click_button 'Log In'
    # visit restaurants_path
    # click_button 'Create New Restaurant'
    # fill_in "restaurant_title", with: "Tito's"
    # fill_in "restaurant_description", with: "Jorge's favorite place"
    # click_button('Create Restaurant')
    # restaurant = Restaurant.first
    # expect(restaurant.creator_id).to eq user.id
    # expect(restaurant.jobs.count).to eq 1
  end

end

