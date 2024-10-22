class DogLocation < ApplicationRecord
  belongs_to :dog
  belongs_to :location
end

