ActiveAdmin.register Owner do
  permit_params :name, :email, :phone_number, :address

  # Specify the filters you want
  filter :name
  filter :email
  filter :phone_number
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone_number
    column :address
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone_number
      f.input :address
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :phone_number
      row :address
    end
  end
end
