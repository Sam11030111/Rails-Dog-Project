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
    breed = breeds.sample
    dog = Dog.create(
      name: Faker::Creature::Dog.name,
      breed: breed,
      age: rand(1..15),
      gender: ['Male', 'Female'].sample,
      owner: owner
    )

    # Fetch and attach an image for the dog breed
    image_url = fetch_dog_image(breed)
    file = URI.open(image_url)
    dog.image.attach(io: file, filename: "#{dog.name}_#{breed}.jpg")

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
