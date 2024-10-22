class CreateDogLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :dog_locations do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
