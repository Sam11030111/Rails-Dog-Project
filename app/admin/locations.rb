ActiveAdmin.register Location do
  permit_params :name, :address, :description,  dog_ids: []

  # Specify the filters you want
  filter :name
  filter :address
  filter :description
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :description
    column "Dogs" do |location|
      location.dogs.map(&:name).join(", ") # Display the dog names
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :description
      f.input :dogs, as: :check_boxes, collection: Dog.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :description
      row "Dogs" do |location|
        location.dogs.map(&:name).join(", ") # Display the dog names
      end
    end
  end
end
