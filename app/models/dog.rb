class Dog < ApplicationRecord
  belongs_to :owner
  has_many :dog_locations, dependent: :destroy
  has_many :locations, through: :dog_locations

  validates :name, :breed, :gender, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
end

