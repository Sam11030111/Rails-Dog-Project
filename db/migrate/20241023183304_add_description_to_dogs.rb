class AddDescriptionToDogs < ActiveRecord::Migration[7.2]
  def change
    add_column :dogs, :description, :text
  end
end
