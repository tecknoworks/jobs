ActiveAdmin.register Job do
  permit_params :description

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  # form do |f|
  #   f.semantic_errors
  #   f.inputs
  #   f.actions         # adds the 'Submit' and 'Cancel' buttons
  # end

  form do |f|
    f.inputs 'Admin Details' do
      f.input :description
    end
    f.actions
  end

end
