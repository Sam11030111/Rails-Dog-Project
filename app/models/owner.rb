class Owner < ApplicationRecord
    has_many :dogs, dependent: :destroy
    
    validates :name, :email, :phone_number, :address, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, uniqueness: true

    def self.ransackable_associations(auth_object = nil)
        ["image_attachment", "image_blob"]
    end
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "name", "email", "phone_number", "address", "updated_at"]
    end
end