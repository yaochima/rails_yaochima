# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

res = Restaurant.new
res.name = "McDonald"
res.category = "FastFood"
res.profile_photo = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Mcdonalds-90s-logo.svg/220px-Mcdonalds-90s-logo.svg.png"
res.rating = "5.0"
res.location = "City Center"
res.price_range = "1-10 yuan"
res.phone_number = "123123123123"
res.lat = "120"
res.long = "42"
res.save

res2 = Restaurant.new
res2.name = "Yunnan Restaurant"
res2.category = "yunnan"
res2.profile_photo = "http://www.seriouseats.com/images/2012/09/20120918-yunnan-cover.jpg"
res2.rating = "4.5"
res2.location = "City Center"
res2.price_range = "20-50 yuan"
res2.phone_number = "123596333441"
res2.lat = "121"
res2.long = "43"
res2.save
