class Owner < ApplicationRecord
    has_many :dogs, dependent: :destroy
    
    validates :name, :email, :phone_number, :address, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, uniqueness: true
end