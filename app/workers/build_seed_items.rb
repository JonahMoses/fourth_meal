class BuildSeedItems
  include Sidekiq::Worker

  def perform(restaurant_id)
    20.times do |r|
      name = Faker::Commerce.product_name + " #{restaurant_id},#{r}"
      description = Faker::Commerce.department
      price = 500
      item = Item.create!(title: name, description: description, price: price, active: true, restaurant_id: restaurant_id )
    end

  end
end



