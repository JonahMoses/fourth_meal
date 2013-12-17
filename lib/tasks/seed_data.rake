desc "20 jobs to make 20 stores"
task :seed_restaurants => :environment do
  10.times do |i|
    BuildSeedRestaurants.perform_async
    puts "creating restaurants job #{i}"
  end
end

# desc "20 jobs to make 400 items"
# task :seed_items => :environment do
#   20.times do |i|
#     BuildSeedItems.perform_async
#     puts "creating items job #{i}"
#   end
# end

# BACKGROUND WORKER - 100,000 known users

