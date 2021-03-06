class BuildSeedRestaurants
  include Sidekiq::Worker

  def perform(r)
    100.times do |i|
      name = restaurant_names.sample
      description = "Gourmet " + Faker::Lorem.sentence
      image = "#{name}_logo.png"
      store = Restaurant.create(
        title: name + "'s" + " Restaurant" + " #{i}, #{r}",
        status: "active",
        slug: name.parameterize,
        image_file_name: image,
        description: description,
        region_id: rand(1..30))
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

  def restaurant_names
    %w[ Adam Louisa Katrina Romeeka BBQ_Billy BenH George Bryana Rolen BenL Tyler Luke Will Jonah Darryl Kevin Antony Lauren Quentin Nikhil Simon Bree Nathaniel Brian Persa Jeff Billy Franklin Jorge ]
  end


end

