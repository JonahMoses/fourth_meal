require "spec_helper"

describe UserMailer do
  describe "logged in user's order_confirmation" do
    let(:user) { User.create(email: "me@example.com",
                        full_name: "Antony",
                        password: "hellothere",
                        password_confirmation: "hellothere") }
    let(:order) { Order.create(user_id: user.id, restaurant_id: 1)}
    let(:mail) { UserMailer.order_confirmation(user, order)}

    it "renders the headers" do
      mail.subject.should eq("Thank you for your order!")
      mail.to.should eq(["me@example.com"])
      mail.from.should eq(["foodfightinfo@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("our order details are below:")
    end
  end

  describe "guest user's order confirmation" do
    let(:user) { User.create(email: "me@example.com",
                        full_name: "Antony",
                        credit_card_number: "1234123412341234",
                        billing_street: "123 Main st",
                        billing_city: "Denver",
                        billing_state: "CO",
                        billing_zip_code: "12345",
                        guest: true)}
    let(:order) { Order.create(user_id: user.id, restaurant_id: 100) }
    let(:mail) { UserMailer.order_confirmation(user, order)}

    it "renders the headers" do
      mail.subject.should eq("Thank you for your order!")
      mail.to.should eq(["me@example.com"])
      mail.from.should eq(["foodfightinfo@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Your order details are below:")
      mail.body.encoded.should match("User Full Name: Antony")
    end
  end

  describe "logged in user's new restaurant confirmation" do
    let(:user) { User.create(email: "me@example.com",
                        full_name: "Antony",
                        password: "hellothere",
                        password_confirmation: "hellothere") }
    let(:restaurant) { Restaurant.create(title: 'BilyBob', description: "Ur Fine Dinin Road Kil Caffe!") }
    let(:mail) { UserMailer.new_restaurant_submission_confirmation(user, restaurant)}

    it "renders the headers" do
      mail.subject.should eq("Thank you for submitting a New Restaurant to FoodFight")
      mail.to.should eq(["me@example.com"])
      mail.from.should eq(["foodfightinfo@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("We are reviewing your submission.")
      mail.body.encoded.should match("Dear Antony,")
    end
  end

end
