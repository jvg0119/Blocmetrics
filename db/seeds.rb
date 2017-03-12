# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# users 
joe = User.new(name: "Joe", email: "joe@example.com", password: "password", password_confirmation: "password")
			joe.skip_confirmation!
			joe.save 
mike = User.new(name: "Mike", email: "mike@example.com", password: "password", password_confirmation: "password")
			mike.skip_confirmation!
			mike.save 

# registered_applications
1.upto(20) do 
	name = Faker::App.unique.name 
	RegisteredApplication.create(name: name, url: "www.#{name}.com", user: User.all.sample )
end

# events
1.upto(150) do |n|
	#Event.create(name: "Event - #{n}", registered_application_id: RegisteredApplication.all.sample.id )
	Event.create(name: Faker::Book.unique.title, registered_application_id: RegisteredApplication.all.sample.id )
end

# print info
puts "*".center(40, "*")
puts
puts "Done seeding".center(40)
puts "#{User.count} - users created".center(40)
puts "#{RegisteredApplication.count} - registered_applications created".center(40)
puts "#{Event.count} - events created".center(40)
puts
puts "*".center(40, "*")





