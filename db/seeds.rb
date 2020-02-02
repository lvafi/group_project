# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all()
Room.destroy_all()
Availability.destroy_all()
Booking.destroy_all()
Course.destroy_all()
Enrollment.destroy_all()
Feature.destroy_all()
Search.destroy_all()

PASSWORD = "supersecret"  

super_user = User.create( 
    first_name: "", 
    last_name: "Stark", 
    email: "noone@winterfell.gov", 
    password: PASSWORD,
    is_admin?: true
) 

users = User.all 
features_array = ["WiFi", "Free Parking", "Paid Parking", "Open Floor Plan", "Whiteboard", "ADA Accessible", "Audio/Visual Equipment", "Desks"]
locations = ["Arbutus Ridge", "Downtown", "Dunbar-Southlands", "Fairview", "Grandview-Woodland", "Kensington-Cedar Cottage", "Kerrisdale", "Killarney", "Kitsilano", "Oakridge", "Marpole", "Mount Pleasant", "Renfrew-Collingwood", "Riley Park", "Shaughnessy", "South Cambie", "Strathcona", "Sunset", "West End", "West Point Grey", "Burnaby", "Coquitlam", "New Westminster", "Richmond"]

10.times do
    Feature.create(
        name: features_array.sample
    )
end

features = Feature.all

10.times do
    random_date = Faker::Date.backward(days:365 * 5)
    r = Room.create(
        name: Faker::Movies::StarWars.planet,
        address: Faker::Address.full_address,
        location: locations.sample,
        capacity: Faker::Number.number(digits: 3),
        price: Faker::Number.decimal(l_digits: 2),
        description: Faker::Movies::StarWars.quote,
        created_at: random_date,
        updated_at: random_date,
        user: users.sample
    )

    if r.valid?
        r.features = features.shuffle.slice(0..rand(features.count))
    end

end

puts Cowsay.say("Generated #{User.count} users.", :frogs)
puts Cowsay.say("Generated #{Room.count} rooms.", :tux)
puts Cowsay.say("Generated #{Feature.count} features.", :dragon)