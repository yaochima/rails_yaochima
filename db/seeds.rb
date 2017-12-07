# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


CATEGORY = ["Fast Food",
            "Sichuan",
            "Hot Pot",
            "French",
            "Japanese"]

def generate_fake_restaurants(base_lat, base_lng)
  restaurant = Restaurant.new
  restaurant.name = Faker::Food.dish + " " + Faker::Company.suffix
  restaurant.category = CATEGORY.sample
  restaurant.profile_photo = "https://picsum.photos/200/300/?random"
  restaurant.rating = (1..5).to_a.sample
  restaurant.location = Faker::Company.suffix
  restaurant.price_per_person = (5..500).to_a.sample
  restaurant.phone_number = Faker::PhoneNumber.phone_number
  restaurant.lat = base_lat - 0.05 + rand / 20
  restaurant.lng = base_lng - 0.05 + rand / 20
  restaurant.save
end

200.times do
  generate_fake_restaurants(104.06, 30.57)
end

