class BuildSeedItems
  include Sidekiq::Worker

  def perform
    20.times do |p|
      sleep 1
      name = Faker::Commerce.product_name
      description = Faker::Commerce.department + " #{p}"
      price = "#{Faker::Number.digit}"
      restaurant_id = "#{p}"+1
      item = Item.create(title: name, description: description, price: price, active: true, restaurant_id: restaurant_id )
    end
  end
end



