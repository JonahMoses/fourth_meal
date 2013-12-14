require 'spec_helper'

describe "dashboard controller" do 

  it "global admin dashboard shows restaurants" do 
    register_admin_user
    FactoryGirl.create(:restaurant)
    visit '/dashboard'
    save_and_open_page
    expect(page).to have_content("Restaurants by Status")
  end

end
