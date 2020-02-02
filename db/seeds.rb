# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


PASSWORD = "supersecret" 

Course.delete_all
Room.delete_all
Availability.delete_all 
Booking.delete_all 
Enrollment.delete_all
Feature.delete_all
Search.delete_all
User.delete_all 

PASSWORD = "supersecret"  

super_user = User.create( 
    first_name: "", 
    last_name: "Stark", 
    email: "noone@winterfell.gov", 
    password: PASSWORD,
    is_admin?: true
) 

puts "Login with #{super_user.email} and password of '#{PASSWORD}'"

20.times do 
    first_name = Faker::Name.first_name 
    last_name = Faker::Name.last_name 
    User.create( 
        first_name: first_name, 
        last_name: last_name,  
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com", 
        password_digest: PASSWORD,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        is_admin?: false
    )  
end 

users = User.all 
puts Cowsay.say("Created #{users.count} users", :tux)  

100.times do
    user = users.sample 
    start_date = Faker::Date.between(from: 1.month.ago, to: 1.month.from_now)
    end_date = Faker::Date.between(from: start_date, to: 1.month.from_now)
    c = Course.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        price: Faker::Number.number(digits: 4),
        range_start_date:start_date,
        range_end_date:end_date,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
end
 
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
puts Cowsay.say("Generated #{Course.count} questions", :frogs)
puts Cowsay.say("Generated #{Room.count} rooms.", :tux)
puts Cowsay.say("Generated #{Feature.count} features.", :dragon)
