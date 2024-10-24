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

# Helper method to fetch a random image for a specific breed
def fetch_dog_image(breed)
  image_url = "https://dog.ceo/api/breed/#{breed}/images/random"
  image_response = URI.open(image_url).read
  image_data = JSON.parse(image_response)
  image_data['message']
rescue
  # Fallback to a default image URL if the API request fails
  "https://via.placeholder.com/300x300.png"
end

# Create 10 Locations first
locations = []
20.times do
  location = Location.create(
    name: Faker::Address.community,
    address: Faker::Address.full_address,
    description: Faker::Lorem.sentence
  )
  locations << location
end

# Create 30 Owners
owners = []
30.times do
  owner = Owner.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address
  )
  owners << owner
end

# Create Dogs and associate them with Locations
dogs = [] # Array to hold created dogs for later association
locations.each do |location|
  5.times do
    breed = breeds.sample
    dog = Dog.create(
      name: Faker::Creature::Dog.name,
      breed: breed,
      age: rand(1..15),
      gender: ['Male', 'Female'].sample,
      description: Faker::Lorem.sentence,
      owner: owners.sample # Randomly assign an existing owner
    )

    # Fetch and attach an image for the dog breed
    image_url = fetch_dog_image(breed)
    file = URI.open(image_url)
    dog.image.attach(io: file, filename: "#{dog.name}_#{breed}.jpg")

    # Associate the dog with the current location
    DogLocation.create(dog: dog, location: location) unless DogLocation.exists?(dog: dog, location: location)
    
    # Add the dog to the array of dogs
    dogs << dog
  end
end

# Associate each dog with random locations
dogs.each do |dog|
  random_locations = locations.sample(rand(1..3)) # Each dog can be associated with 1 to 3 random locations
  random_locations.each do |location|
    DogLocation.create(dog: dog, location: location) unless DogLocation.exists?(dog: dog, location: location)
  end
end

puts "Database seeded successfully with #{Owner.count} owners, #{Dog.count} dogs, #{Location.count} locations, and #{DogLocation.count} dog_location records."
