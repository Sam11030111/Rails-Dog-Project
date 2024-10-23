class Location < ApplicationRecord
    has_many :dog_locations, dependent: :destroy
    has_many :dogs, through: :dog_locations
  
    validates :name, :address, presence: true

    def self.ransackable_associations(auth_object = nil)
        ["image_attachment", "image_blob"]
    end
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "name", "address", "description", "updated_at"]
    end
end