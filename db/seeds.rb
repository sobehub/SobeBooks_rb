# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

puts '========== Started seeding Client and Vendors'
20.times.each do |i|
  Client.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'active', user_id: user.id)
  Vendor.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'active', user_id: user.id)

  Client.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'inactive', user_id: user.id)
  Vendor.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'inactive', user_id: user.id)

  Client.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'past due', user_id: user.id)
  Vendor.create(name: Faker::Name.name, company_name: Faker::Company.name,
                email: Faker::Internet.email, status: 'past due', user_id: user.id)
end
puts '========== Process completed successfully'