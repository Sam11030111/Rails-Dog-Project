class Dog < ApplicationRecord
  has_one_attached :image

  belongs_to :owner
  has_many :dog_locations, dependent: :destroy
  has_many :locations, through: :dog_locations

  validates :name, :breed, :gender, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "name", "breed", "age", "gender", "owner_id", "updated_at", 'image']
  end
end

