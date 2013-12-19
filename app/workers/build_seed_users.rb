class BuildSeedUsers
  include Sidekiq::Worker

  def perform
    100.times do |p|
      email                 = "#{p}" + Faker::Internet.email
      full_name             = Faker::Name.name
      password              = "password"
      password_confirmation = "password"
      billing_street        = "1234 Maple St"
      billing_apt           = "G6"
      billing_city          = "Denver"
      billing_state         = "CO"
      billing_zip_code      = 80204
      user = User.create(
        email: email,
        full_name: full_name,
        password: password,
        password_confirmation: password_confirmation,
        billing_street: billing_street,
        billing_apt: billing_apt,
        billing_city: billing_city,
        billing_state: billing_state,
        billing_zip_code: billing_zip_code)
    end
  end
end
