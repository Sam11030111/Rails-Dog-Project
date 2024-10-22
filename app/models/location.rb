class Location < ApplicationRecord
    has_many :dog_locations, dependent: :destroy
    has_many :dogs, through: :dog_locations
  
    validates :name, :address, presence: true
end