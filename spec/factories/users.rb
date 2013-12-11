# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    display_name { Faker::Name.name }
    password "password"
    password_confirmation "password"
    admin false
    guest false

    trait :guest do
      email { "" }
      full_name { "" }
      # display_name { "" }
      guest true
    end
  end
end
