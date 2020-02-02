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

super_user = User.create( 
    first_name: "Jon", 
    last_name: "Snow", 
    email: "js@winterfell.gov", 
    password: PASSWORD,
    is_admin?: true
) 

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
 
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"

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

50.times do
    user = users.sample 
    r = Room.create(
        name: Faker::Hacker.say_something_smart,
        address: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        capacity: Faker::Number.number(digits: 2),
        price: Faker::Number.number(digits: 3),
        location: Faker::Hacker.say_something_smart,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
end

puts Cowsay.say("Generated #{Course.count} questions", :frogs)
puts Cowsay.say("Generated #{Room.count} answers", :tux)
puts Cowsay.say("Generated #{User.count} users", :dragon)




