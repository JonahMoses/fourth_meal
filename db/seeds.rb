katrina_user = User.create(
  email: "demo+katrina@jumpstartlab.com",
  full_name: "Katrina Owen",
  display_name: "kytrinyx",
  password: "password",
  password_confirmation: "password",
  admin: "true"
)

jeff_user = User.create(
  email: "demo+jeff@jumpstartlab.com",
  full_name: "Jeff Casimir",
  display_name: "j3",
  password: "password",
  password_confirmation: "password",
  admin: "true"
)

platform_admin_1 = User.create(
  email: "jonahkmoses+admin1@gmail.com",
  full_name: "admin",
  display_name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: "true"
)

 platform_admin_2 = User.create(
  email: "jonahkmoses+admin2@gmail.com",
  full_name: "admin",
  display_name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: "true"
)

  platform_admin_2 = User.create(
    email: "admin@example.com",
    full_name: "adminadmin",
    display_name: "adminadmin",
    password: "password",
    password_confirmation: "password",
    admin: "true"
  )

regions = %w[ Garland Glendale Greensboro Henderson Hialeah Irvine Laredo Lincoln Lubbock Madison Memphis Mesa Miami Milwaukee Minneapolis Modesto Montgomery Newark Oakland Omaha Orlando Oxnard Phoenix Pittsburgh Plano Portland Raleigh Reno Riverside Seattle ]
regions.each do |region|
  Region.create(name: region)
  puts "created region #{region}"
end

