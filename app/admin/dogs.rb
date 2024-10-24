ActiveAdmin.register Dog do
  permit_params :name, :breed, :age, :gender, :owner_id, :image, location_ids: []

  # Specify the filters you want
  filter :name
  filter :breed
  filter :age
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :breed
    column :age
    column :gender
    column :owner
    column :locations do |dog|
      dog.locations.map(&:name).join(', ') # Show location names
    end
    column :image do |dog|
      if dog.image.attached?
        image_tag(url_for(dog.image), size: "50x50") # Display a small thumbnail
      end
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :breed
      f.input :age
      f.input :gender
      f.input :owner
      f.input :locations, as: :select, multiple: true, collection: Location.all.map { |location| [location.name, location.id] }
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :breed
      row :age
      row :gender
      row :owner
      row :locations do |dog|
        dog.locations.map(&:name).join(', ') # Show location names
      end
      row :image do |dog|
        if dog.image.attached?
          image_tag(url_for(dog.image) , size: "100x100")
        end
      end
    end
  end
end

