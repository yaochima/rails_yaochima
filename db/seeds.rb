# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# CATEGORY = ["Fast Food",
#             "Sichuan",
#             "Hot Pot",
#             "French",
#             "Japanese"]

# def generate_fake_restaurants(base_lat, base_lng)
#   restaurant = Restaurant.new
#   restaurant.name = Faker::Food.dish + " " + Faker::Company.suffix
#   restaurant.category = CATEGORY.sample
#   restaurant.profile_photo = "https://picsum.photos/200/300/?random"
#   restaurant.rating = (1..5).to_a.sample
#   restaurant.location = Faker::Company.suffix
#   restaurant.price_per_person = (5..100).to_a.sample
#   restaurant.phone_number = Faker::PhoneNumber.phone_number
#   restaurant.lat = base_lat - 0.05 + rand / 20
#   restaurant.lng = base_lng - 0.05 + rand / 20
#   restaurant.save
# end

# 1000.times do
#   generate_fake_restaurants(30.588066, 104.05435)
# end
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'shop_list_done.csv'))
csv = CSV.parse(csv_text, :headers => true)
count = 1
csv.each do |row|
  if Restaurant.find_by(dianping_id: row['dianping_id']) || row['rating_flavor'] == "N/A"
    p "restaurant already exists OR is not good enough"
  else
    r = Restaurant.new
    r.dianping_id = row['dianping_id'].to_i
    r.dianping_url = row['dianping_url']
    r.name = row['name']
    r.category = row['category']
    r.profile_photo = row['photo_url']
    r.rating = ((row['rating_flavor'].to_f + row['rating_environ'].to_f + row['rating_service'].to_f) / 6).round(0)
    r.rating_flavor = row['rating_flavor'].to_f
    r.rating_environ = row['rating_environ'].to_f
    r.rating_service = row['rating_service'].to_f
    r.address = row['address']
    r.price_per_person = row['price_per_person'].to_i
    r.phone_number = row["phone_number"]
    r.lat = row['lat']
    r.lng = row['lng']
    r.save
    count += 1
    p "created #{count}"
  end
end

