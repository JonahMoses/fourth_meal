desc "creating restaurants"
task :seed_restaurants => :environment do
  100.times do |i|
    BuildSeedRestaurants.perform_async(i)
    puts "creating restaurant job #{i}"
  end
end

desc "creating users"
task :seed_users => :environment do
  10.times do |i|
    BuildSeedUsers.perform_async
    puts "creating user job #{i}"
  end
end

desc "creating items"
task :seed_items => :environment do
  10000.times do |i|
    BuildSeedItems.perform_async(i)
    puts "creating item job #{i}"
  end
end
