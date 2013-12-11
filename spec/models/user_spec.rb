require 'spec_helper'

describe User do

  it "encrypts the password" do
    user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :password => "foobar", :password_confirmation => "foobar")
    user.save
    user.password_hash.length.should eq(60)
    user.password_salt.length.should eq(29)
  end

  it "limits short length of display_name" do
    short_user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                          :display_name => "1",
                          :password => "foobar", :password_confirmation => "foobar")
    short_user.valid?.should be_false
  end

  it "limits long length of display_name" do
    long_user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                         :display_name => "3"*33,
                         :password => "foobar", :password_confirmation => "foobar")
    long_user.valid?.should be_false
  end

  it "it accepts good length display_name" do
    user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :display_name => "3"*30,
                    :password => "foobar", :password_confirmation => "foobar")
    user.valid?.should be_true
  end

  it "rejects blank full_name" do
    user = User.new(:email => "dragons@example.com", :full_name => "  ",
                    :display_name => "3"*30,
                    :password => "foobar", :password_confirmation => "foobar")
    user.valid?.should be_false
  end

  it "rejects invalid email addresses" do
    no_at = User.new(:email => "dragonxample.com", :full_name => "yeas",
                     :password => "foobar", :password_confirmation => "foobar")
    no_tld = User.new(:email => "dragonx@llample", :full_name => "yeas",
                      :password => "foobar", :password_confirmation => "foobar")
    no_name = User.new(:email => "@dragonxample.com", :full_name => "yeas",
                       :password => "foobar", :password_confirmation => "foobar")
    valid_user = User.new(:email => "dragon@example.com", :full_name => "yeas",
                          :password => "foobar", :password_confirmation => "foobar")
    no_at.valid?.should be_false
    no_tld.valid?.should be_false
    no_name.valid?.should be_false
    valid_user.valid?.should be_true
  end

  it "rejects case-insensitive duplicate emails" do
    first_user = User.new(:email => "first_user@example.com", :full_name => "yeas",
                          :password => "foobar", :password_confirmation => "foobar")
    first_user.save!
    second_user = User.new(:email => "First_user@example.com", :full_name => "yeas",
                           :password => "foobar", :password_confirmation => "foobar")
    first_user.valid?.should be_true
    second_user.valid?.should be_false
  end

  it "saves a users email address downcased" do
    first_user = User.new(:email => "First_user@example.com", :full_name => "yeas",
                          :password => "foobar", :password_confirmation => "foobar")
    first_user.save!

    expect(first_user.email).to eq("first_user@example.com")
  end

  describe '#validate_guest_order' do
    let(:user) { FactoryGirl.create(:user, :guest)}

    it 'requires all information' do
      user.validate_guest_order
      user.errors[:email].should include("is invalid")
      user.errors[:full_name].should include("is invalid")
      user.errors[:credit_card_number].should include("is invalid")
      user.errors[:billing_street].should include("is invalid")
      user.errors[:billing_city].should include("is invalid")
      user.errors[:billing_state].should include("is invalid")
      user.errors[:billing_zip_code].should include("is invalid")
    end

    it 'returns false when invalid' do
      target = user.validate_guest_order
      expect(target).to eq false
    end

    let(:user_attrs) do
      {
        email: Faker::Internet.email
      }
    end

    it 'returns true when valid' do
      user.update_attributes(user_attrs)
      user.validate_guest_order
      user.errors[:email].should_not include("email required")
    end
  end

end
