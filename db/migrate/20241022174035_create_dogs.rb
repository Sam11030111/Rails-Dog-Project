class CreateDogs < ActiveRecord::Migration[7.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.string :gender
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
