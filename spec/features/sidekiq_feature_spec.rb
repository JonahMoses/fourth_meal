require 'spec_helper'

describe "access to /sidekiq" do

  xit "rejects guest user" do
    expect{visit '/sidekiq'}.to raise_error(ActionController::RoutingError)
  end

  xit "rejects member user" do
    log_in_user
    expect{visit '/sidekiq'}.to raise_error(ActionController::RoutingError)
  end

  xit "allows admin user" do
    register_admin_user
    visit '/sidekiq'
    expect(page).not_to have_content 'Not authorized'
    within('.navbar-brand') do
      expect(page).to have_content 'Sidekiq'
    end
  end
end


