require 'spec_helper'

describe UsersController do

  before :all do
    register_changeable_user
  end

  describe "routing" do
    it "routes to #new" do
      expect(:get => "/sign_up").to route_to(
             :controller => "users",
             :action => "new"
      )
    end
  end

  describe "updating a user's information" do
    it "updates email address" do
      user = User.find_by(:email => "confused@example.com")
      user.update(:email => "fools@example.com")
      expect(user.email).to eq("fools@example.com")
    end
  end

  describe "new session" do
    it "sets session[:user_id] for valid user" do
      User.create!(:email => "simon@example.com", :full_name => "yep",
                   :password => "foobar", :password_confirmation => "foobar")
      user = User.authenticate("simon@example.com", "foobar")
      user.should_not be_nil
    end
  end

  describe "POST create" do
    before :each do
      UserMailerWorker.stub :perform_async
    end

    it "creates a user" do
      expect do
        post(:create, user: {email: "abc@example.com", full_name: "Abc Xyz", password: "password", password_confirmation: "password"})
      end.to change(User, :count).by(1)
    end

    it "sends a welcome email to the user" do
      post(:create, user: {email: "abc@example.com", full_name: "Abc Xyz", password: "password", password_confirmation: "password"})
      expect(UserMailerWorker).to have_received(:perform_async).with("abc@example.com","Abc Xyz")
    end
  end

end
