require 'faker'
require 'open-uri'
require 'json'

# Fetch breeds from the Dog API
breed_url = 'https://dog.ceo/api/breeds/list/all'
breed_response = URI.open(breed_url).read
breed_data = JSON.parse(breed_response)

# Extract all breeds into an array
breeds = breed_data['message'].keys

# Clear existing records
Owner.destroy_all
Dog.destroy_all
Location.destroy_all
DogLocation.destroy_all

# Create 30 Owners
30.times do
  owner = Owner.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address
  )

  # Create 5 Dogs for each owner
  5.times do
    dog = Dog.create(
      name: Faker::Creature::Dog.name,
      breed: breeds.sample,
      age: rand(1..15),
      gender: ['Male', 'Female'].sample,
      owner: owner
    )

    # Create 3 Locations for each dog
    3.times do
      location = Location.find_or_create_by(
        name: Faker::Address.community,
        address: Faker::Address.full_address,
        description: Faker::Lorem.sentence
      )

      DogLocation.create(dog: dog, location: location)
    end
  end
end

puts "Database seeded successfully with #{Owner.count} owners, #{Dog.count} dogs, #{Location.count} locations, and #{DogLocation.count} dog_location records."


