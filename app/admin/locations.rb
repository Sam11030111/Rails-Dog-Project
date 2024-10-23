ActiveAdmin.register Location do
  permit_params :name, :address, :description

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
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :description
    end
  end
end
