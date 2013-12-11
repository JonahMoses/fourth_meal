require 'spec_helper'

describe "the signup process", :type => :feature do

  it "lets me create an account" do
    visit root_path
    click_on("Become a member")
    fill_in 'user_email',                 :with => "bj@example.com"
    fill_in 'user_full_name',             :with => "Bo Jangles"
    fill_in 'user_display_name',          :with => "BJ"
    fill_in 'user_password',              :with => "foobarbaz"
    fill_in 'user_password_confirmation', :with => "foobarbaz"
    click_link_or_button 'Create User'
    expect(page).to have_content 'Signed up!'
  end
end

describe "the purchase page" do

  it "should have sign up, sign in, and guest purchase forms" do
    visit purchase_users_path
    expect(current_path).to eq(purchase_users_path)
    expect(page).to have_content 'Sign Up'
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Checkout As Guest'
  end

end

describe "the signin process" do
  before :each do
    register_user
  end

  it "logs me in" do
    within("#flash_notice") do
      expect(page).to have_content 'Logged in'
    end
  end

  it "logs me out" do
    click_link_or_button 'Log Out'
    within("#flash_notice") do
      expect(page).to have_content 'Logged out'
    end
    expect(page).to have_content 'Log In'
  end

end

describe "guest user" do

  it "cannot edit item" do
    item = make_an_item_via_db
    visit edit_item_path(item)
    page.should have_content("Not authorized")
  end

end

describe "member" do

  it "cannot edit item" do
    item = make_an_item_via_db
    register_user
    visit edit_item_path(item)
    page.should have_content("Not authorized")
  end

  it "can edit her own user details" do
    register_changeable_user
    click_on 'My profile'
    fill_in 'user_email', :with => "adminOne@example.com"
    fill_in 'user_password', :with => "password"
    fill_in 'user_password_confirmation', :with => "password"
    click_link_or_button 'Update User'
    page.status_code.should eql(200)
    within('.navbar') do
      page.should have_content('conf')
    end
  end

end

describe "admin user" do

  it "can edit an item" do
    item = make_an_item_via_db
    register_admin_user
    visit edit_item_path(item)
    page.should_not have_content("Not authorized")
  end

end


