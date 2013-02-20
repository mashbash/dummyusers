require 'faker'
require_relative '../app/models/user'

100.times do
  User.create(first_name: Faker::Name.first_name, 
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: Faker::Lorem.characters(10),
              secret_url: Faker::Lorem.characters(10))
end
