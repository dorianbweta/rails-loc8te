# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
puts 'Cleaning database...'
Trip.destroy_all
Ride.destroy_all
PlatformCity.destroy_all
User.destroy_all
City.destroy_all
Platform.destroy_all


puts "Creating users..."

visitor = User.create!(
  first_name: "Visitor",
  last_name: "Visitor",
  email: "visitor@gmail.com",
  phone: "7020890872",
  password: "password"
)

moses = User.create!(
  first_name: "Moses",
  last_name: "Alligator",
  email: "moses@gmail.com",
  phone: "7020890872",
  password: "password"
)

piscilla = User.create!(
  first_name: "Priscilla",
  last_name: "Adilla",
  email: "priscilla@gmail.com",
  phone: "7020560872",
  password: "password"
)

dorian = User.create!(
  first_name: "Dorian",
  last_name: "Polo",
  email: "dorian@gmail.com",
  phone: "7020780872",
  password: "password"
)

puts "Creating City..."

newyork = City.create!(
  name: "New York",
  country: "United States"
)

nevada = City.create!(
  name: "Las Vegas",
  country: "United States"
)

florida = City.create!(
  name: "Miami",
  country: "United States"
)

california = City.create!(
  name: "Los angeles",
  country: "United States"
)

puts "Creating platforms..."

uber = Platform.create!(
  name: "Uber",
  rating: 4.9,
)

lyft = Platform.create!(
  name: "Lyft",
  rating: 4.5,
)

arro = Platform.create!(
  name: "Arro",
  rating: 4.2
)

puts "Merging cities and platforms..."

PlatformCity.create!(
  platform_id: uber.id,
  city_id: newyork.id
)

PlatformCity.create!(
  platform_id: lyft.id,
  city_id: newyork.id
)

PlatformCity.create!(
  platform_id: arro.id,
  city_id: newyork.id
)

PlatformCity.create!(
  platform_id: lyft.id,
  city_id: nevada.id
)

PlatformCity.create!(
  platform_id: uber.id,
  city_id: florida.id
)

puts "Generating locations..."

nypizza = Location.create!(
  address: "413 8th Ave, New York, NY 10001",
  name: "NY Pizza Suprema"
)

hells_kitchen = Location.create!(
  address: "3570 Las Vegas Blvd S, Las Vegas, NV 89109",
  name: "Hells Kitchen"
)

disney_world = Location.create!(
  address: "1180 Seven Seas Drive, Lake Buena Vista, FL 32830",
  name: "Disney World"
)

six_flags = Location.create!(
  address: "26101 Magic Mountain Pkwy, Valencia, CA 91355",
  name: "Six flags"
)

south = Location.create!(
  address: "3333 Bristol St, Costa Mesa, CA 92626",
  name: "South Coast Plaza"
)

mgm = Location.create!(
  address: " 3799 S Las Vegas Blvd, Las Vegas, NV 89109",
  name: "MGM GRAND"
)

pinball = Location.create!(
  address: "4925 Las Vegas Blvd S, Las Vegas, NV 89119",
  name: "Pinball Hall of Fame"
)

uberhq = Location.create!(
  address: "1455 Market St, San Francisco, CA 94103",
  name: "Uber HQ"
)

coittower = Location.create!(
  address: "1 Telegraph Hill Blvd, San Francisco, CA 94133",
  name: "Coit Tower"
)

puts "Gathering all rides..."

ride1 = Ride.create!(
  user_id: moses.id,
  platform_id: uber.id,
  city_id: nevada.id,
  ETA: 23,
  fare: 300,
  category: "luxury",
  link_to_app: ""
)

trip1 = Trip.create!(
  user_id: moses.id,
  ride_id: ride1.id,
  start_location_id: mgm.id,
  end_location_id: hells_kitchen.id
)

ride2 = Ride.create!(
  user_id: moses.id,
  platform_id: arro.id,
  city_id: nevada.id,
  ETA: 33,
  fare: 20,
  category: "economy",
  link_to_app: ""
)

trip2 = Trip.create!(
  user_id: moses.id,
  ride_id: ride2.id,
  start_location_id: hells_kitchen.id,
  end_location_id: pinball.id
)

ride3 = Ride.create!(
  user_id: moses.id,
  platform_id: lyft.id,
  city_id: nevada.id,
  ETA: 18,
  fare: 30,
  category: "green",
  link_to_app: ""
)

trip3 = Trip.create!(
  user_id: moses.id,
  ride_id: ride3.id,
  start_location_id: pinball.id,
  end_location_id: mgm.id
)

ride4 = Ride.create!(
  user_id: moses.id,
  platform_id: lyft.id,
  city_id: newyork.id,
  ETA: 18,
  fare: 30,
  category: "green",
  link_to_app: ""
)

trip4 = Trip.create!(
  user_id: moses.id,
  ride_id: ride4.id,
  start_location_id: uberhq.id,
  end_location_id: coittower.id
)

ride5 = Ride.create!(
  user_id: moses.id,
  platform_id: arro.id,
  city_id: newyork.id,
  ETA: 5,
  fare: 150,
  category: "luxury",
  link_to_app: ""
)

trip5 = Trip.create!(
  user_id: moses.id,
  ride_id: ride5.id,
  start_location_id: coittower.id,
  end_location_id: uberhq.id
)
