require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do
    user = User.create(email: "me@example.com",
                        full_name: "Antony",
                        password: "hellothere",
                        password_confirmation: "hellothere")
    order = Order.create(user_id: user.id, restaurant_id: 1)
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

end
