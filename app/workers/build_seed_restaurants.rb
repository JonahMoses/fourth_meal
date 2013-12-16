class BuildSeedRestaurants
  include Sidekiq::Worker

  def perform
    10.times do |i|
      name = Faker::Company.name + "#{i}"
      description = Faker::Company.catch_phrase
      store = Restaurant.create(
        title: name,
        status: "active",
        slug: name.parameterize,
        description: description)
      2.times do |u|
        user = User.create(
          email: "#{u}"+Faker::Internet.email,
          full_name: Faker::Name.name,
          display_name: Faker::Name.name,
          password: "password",
          password_confirmation: "password",
          admin: "false")
        job = Job.create(
          role: "Admin",
          restaurant_id: store.id,
          user_id: user.id)
      end
    end
  end

end

