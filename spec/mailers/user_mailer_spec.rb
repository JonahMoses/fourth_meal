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
      mail.body.encoded.should match("Thank you for ordering with FoodFight!")
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
      mail.body.encoded.should match("Thank you for ordering with FoodFight!")
      mail.body.encoded.should match("User Full Name: Antony")
    end
  end

end
